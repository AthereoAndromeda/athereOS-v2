#!/usr/bin/env nu
def get-vol [] {
    let volume = wpctl get-volume @DEFAULT_AUDIO_SINK@

    let is_muted: bool = $volume
        | str contains "[MUTED]"

    if $is_muted {
        return "MUTED"
    } else {
        let nums: list<string> = $volume
            | split words
            | last 2

        let d1 = $nums | get 0 | into int | $in * 100
        let d2 = $nums | get 1 | into int
        let s = $d1 + $d2
        return $s
    }
}
def main [] {
    # 1. Output initial volume
    print (get-vol)
    # 2. Listen for PipeWire events
    pactl subscribe
        | lines
        | where $it =~ "sink"
        | each {|_| print (get-vol) }
}

def "main change-vol" [dir: string] {
    if $dir == "up" {
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    } else {
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    }
}

def "main microphone" [] {
    wpctl get-volume @DEFAULT_AUDIO_SOURCE@
        | parse-volume $in
        | print

    pactl subscribe
        | lines
        | where $it =~ "source"
        | each {|_|
          wpctl get-volume @DEFAULT_AUDIO_SOURCE@
            | parse-volume $in
            | print
        }
}

def parse-volume [s:string] {
    let is_muted: bool =  $s | str contains "[MUTED]"

    if $is_muted {
        return "MUTED"
    } else {
        return " "
    }
}
