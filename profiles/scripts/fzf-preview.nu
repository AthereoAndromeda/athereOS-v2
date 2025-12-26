#!/usr/bin/env nu

def main [subcommand?: string, row?: string] {
    match $subcommand {
        "preview" => {
            # Use regex to check if the row contains binary data
            if ($row | str contains "[[ binary data") {
                # Decode and pipe to chafa for image preview
                # FZF_PREVIEW_COLUMNS and LINES are passed as env vars by fzf
                let size = $"($env.FZF_PREVIEW_COLUMNS)x($env.FZF_PREVIEW_LINES)"

                if $env.TERM_PROGRAM == "WezTerm" {
                    # $row | cliphist decode | chafa -f sixel -s $size
                    $row | cliphist decode | timg -p s $"-g($size)" -
                } else {
                    # $row | cliphist decode | chafa -f kitty -s $size
                    $row | cliphist decode | timg -p k $"-g($size)" -
                }
                # $row | cliphist decode | select_decoder(size)
            } else {
                # Decode and print text preview
                $row | cliphist decode
            }
        }
        _ => {
            # Default action: list and select
            let script_path = ($env.CURRENT_FILE) # Gets the path to this script
            
            let id = (
                cliphist list 
                | fzf --preview $"($script_path) preview {}"
            )

            if ($id | is-empty) { return }

            $id | cliphist decode | wl-copy
        }
    }
}
