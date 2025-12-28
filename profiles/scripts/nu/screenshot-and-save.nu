#!/usr/bin/env nu

def "main clipboard" [--fullscreen (-f)] {
  if $fullscreen {
    grim - | wl-copy
  } else {
    grim -g $"(slurp)" - | wl-copy
  }
  
  let action = (^notify-send
    --urgency=low
    -t 5000
    --action "edit=Edit File"
    "Screenshot Saved to Clipboard"
  )

  match $action {
    "edit" => { wl-paste | swappy -f - -o - | wl-copy }
    _ => {}
  }
}

def main [--fullscreen (-f)] {
  let ss_dir = ($env.HOME | path join "Pictures" "Screenshots")
  let grim_format =  (^date +%Y%m%d_%Hh%Mm%Ss_grim.png)
  let ss_path = $ss_dir | path join $grim_format

  if $fullscreen {
    grim $ss_path
  } else {
    grim -g $"(slurp)"  $ss_path
  }
  
  let action = (^notify-send
    --urgency=low
    -h $"string:image-path:($ss_path)"
    -t 5000
    --action "preview=Preview File"
    --action "yazi=Open File Location"
    --action "edit=Edit File"
    --action "delete=Delete File"
    "Screenshot Saved"
  )

  match $action {
      "yazi" => { wezterm start -- yazi $ss_dir }
      "edit" => { swappy -f $ss_path -o $ss_path  }
      "preview" => { ^xdg-open $ss_path }
      "delete" => { ^trash $ss_path }
      _ => {}
  }

}
