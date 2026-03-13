#!/usr/bin/env nu

def main [] {
  let niri_format =  (^date +Screenshot-Niri_%Y-%m-%dT%H-%M-%S.png)
  let ss_dir = ($env.XDG_PICTURES_DIR | path join "Screenshots")
  let ss_path = ($ss_dir | path join $niri_format) 

  niri msg action screenshot --path $ss_path
  
  let action = (^notify-send
    --urgency=low
    -h $"string:image-path:($ss_path)"
    -t 10000
    --action "preview=Preview File"
    --action "yazi=Open File Location"
    --action "edit=Edit File"
    --action "delete=Delete File"
    "Screenshot Saved"
  )

  match $action {
      "yazi" => { ^wezterm start -- yazi $ss_dir }
      "edit" => { ^swappy -f $ss_path -o $ss_path  }
      "preview" => { ^xdg-open $ss_path }
      "delete" => { ^trash $ss_path }
      _ => {}
  }
}
