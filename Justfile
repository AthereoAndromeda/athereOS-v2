set dotenv-load
set shell := ["nu", "-c"]

alias fmt := format
alias s := switch
alias t := test
alias b := boot
alias l := list
alias td := test-debug
alias up := update
alias upc := update-ci
alias opt := optimise
alias rm := delete-generations
alias rmr := delete-generations-range

net := "true"
rebuild-opts := if net == "true" { "" } else { "--no-net --offline" }

default:
    just --list
    # just --choose


# Build in `switch` mode and add the generation to the bootloader
[group('build')]
switch: format _git-add
     sudo -S nixos-rebuild --flake . {{ rebuild-opts }} switch

# Build in `test` mode
[group('build')]
test: format _git-add
     sudo nixos-rebuild --flake . test

# Build in `boot` mode
[group('build')]
boot: format _git-add
     sudo nixos-rebuild --flake . boot

# Build in `test` mode, with lots of debug flags
[group('build')]
test-debug eval-cache="true": format _git-add
     sudo nixos-rebuild --flake . --option eval-cache {{eval-cache}} --show-trace --print-build-logs --verbose test


# Format all `.nix` files using Alejandra
[group('lints')]
format:
    alejandra . 

# Update Nix Flakes
[group('nix/utils')]
update:
     sudo nix flake update
   
# Update Nix Flakes, Test, Commit
[group('nix/utils')]
update-ci: update test
    git commit -m "chore(nix): Update Flake"

# Cleans nix garbage
[group('nix/utils')]
clean older-than="3d":
     sudo nix-collect-garbage --delete-older-than "{{older-than}}"

# Cleans old nix garbage
[group('nix/utils')]
clean-old:
     sudo nix-collect-garbage --delete-old

# Lists all Nix Generations
[group('nix/utils')]
list:
   nixos-rebuild list-generations 

# Delete specified generations
[group('nix/utils')]
delete-generations +gen:
    sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations {{gen}}
    
# Delete specified generations
[group('nix/utils')]
delete-generations-range range:
     sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations ...({{range}} | each {|it| $it})

# Optimize and compresses nix store. This may take a long while.
[group('nix/utils')]
optimise:
    nix-store --optimise --verbose

# Searches through all files for TODO:
[group('utils')]
todo:
    rg -g '!Justfile' -g '!todo.md' -i "(?-i)TODO"
    
# Searches through all files for FIX or FIXME:
[group('utils')]
fix:
    rg -g '!Justfile' -g '!todo.md' -i "(?-i)FIX(ME)?"

_git-add:
    @git add .
