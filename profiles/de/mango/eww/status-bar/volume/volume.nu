#!/usr/bin/env nu

def get-vol [] {
    # Get volume, handle the "[MUTED]" string, and convert to integer
    let raw = (wpctl get-volume @DEFAULT_AUDIO_SINK@ | str trim)
    let is_muted = ($raw | str contains "[MUTED]")
    
    if $is_muted {
        echo "muted"
    } else {
        # Extracts '0.45' from 'Volume: 0.45', converts to float, then %
        $raw
            | split row ' '
            | get 1
            | into float
            | $in * 100
            | math round
            | into string
    }
}

def main [] {
    # 1. Output initial volume
    print (get-vol)

    # 2. Listen for PipeWire events
    # We use lines --buffer to ensure Eww gets the output immediately
    pactl subscribe 
        | lines 
        | where $it =~ "sink" 
        | each { |_| print (get-vol) }
}

def "main change-vol" [dir: string] {
  if $dir == "up" {
    wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
  } else {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  }
}

def "main mute" [] {
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
}
