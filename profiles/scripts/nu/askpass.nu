#!/usr/bin/env nu

def run-in-wezterm [cmd: string] {
    let tmp = (mktemp -p "/run/user/1000/" askpass.XXXXXX)    
    chmod 600 $tmp
    ^wezterm start --always-new-process --class askpass -- nu -c $"($cmd) | save -f ($tmp)"
    
    # Wait until the file is populated (polling)
    while (open $tmp | is-empty) { sleep 300ms }
    
    let sudo_pass = (open $tmp)
    rm $tmp
    return $sudo_pass
}


def "main spawn-window" [] {
        let fifo = $"/run/user/(id -u)/askpass-(random chars --length 5)"

        if (not ($fifo | path exists)) {
            mkfifo $fifo
            chmod 600 $fifo
        }

        job spawn {
            ^wezterm start  --always-new-process --class askpass -- nu -c $"systemd-ask-password --emoji=yes --echo=no | save -f ($fifo)"
                | save -f /dev/null
        } | save -f /dev/null

        let password = (open -r $fifo) | str trim
        print $password
        rm $fifo
}

def main [prompt?: string] {
    # Check if running on terminal, if not spawn one
    # if (is-terminal --stdin) {
    #     ^systemd-ask-password ($prompt | default "Enter Password:")
    # } else {
        main spawn-window 
    # }
}
