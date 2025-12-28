#!/usr/bin/env nu

def run-in-wezterm [cmd: string] {
    let tmp = (mktemp --tmpdir askpass.XXXXXX)    
    ^wezterm start --always-new-process --class askpass -- nu -c $"($cmd) | save -f ($tmp)"
    
    # Wait until the file is populated (polling)
    while (open $tmp | is-empty) { sleep 300ms }
    
    let sudo_pass = (open $tmp)
    rm $tmp
    
    return $sudo_pass
}

def main [prompt?: string] {
    # Check if running on terminal, if not spawn one
    if (is-terminal --stdin) {
        ^systemd-ask-password ($prompt | default "Password:")
    } else {
        (run-in-wezterm "systemd-ask-password") | print $in 
    }
}
