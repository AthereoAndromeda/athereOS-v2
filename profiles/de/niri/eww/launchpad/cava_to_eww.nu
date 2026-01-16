#!/usr/bin/env nu

def main [] {
    # -p points to your config
    cava -p ./launchpad/cava.ini | lines | each { |line|
        if ($line | str trim | is-empty) {} # Skip empty lines
        
        let list = ($line | split row ";" | drop 1 | each { into int })
        if ($list | length) > 0 {
            $list | to json --raw | print
        }
    }
}
