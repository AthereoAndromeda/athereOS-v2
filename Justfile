set dotenv-load

alias fmt := format
alias s := switch
alias t := test
alias b := boot
alias l := list
alias td := test-debug
alias up := update
alias upc := update-ci
alias opt := optimise

net := "true"
rebuild-opts := if net == "true" { "" } else { "--no-net --offline" }

default:
    just --list
    # just --choose


# Build in `switch` mode and add the generation to the bootloader
[group('build')]
switch: format _git-add
    echo $SUDO_PASS | sudo -S nixos-rebuild --flake . {{ rebuild-opts }} switch

# Build in `test` mode
[group('build')]
test: format _git-add
    echo $SUDO_PASS | sudo -S nixos-rebuild --flake . test

# Build in `boot` mode
[group('build')]
boot: format _git-add
    echo $SUDO_PASS | sudo -S nixos-rebuild --flake . boot

# Build in `test` mode, with lots of debug flags
[group('build')]
test-debug eval-cache="true": format _git-add
    echo $SUDO_PASS | sudo -S nixos-rebuild --flake . --option eval-cache {{eval-cache}} --show-trace --print-build-logs --verbose test


# Format all `.nix` files using Alejandra
[group('lints')]
format:
    alejandra . 

# Update Nix Flakes
[group('nix/utils')]
update:
    echo $SUDO_PASS | sudo -S nix flake update
   
# Update Nix Flakes, Test, Commit
[group('nix/utils')]
update-ci: update test
    git commit -m "chore(nix): Update Flake"

# Cleans nix garbage
[group('nix/utils')]
clean older-than="3d":
    echo $SUDO_PASS | sudo -S nix-collect-garbage --delete-older-than "{{older-than}}"

# Cleans old nix garbage
[group('nix/utils')]
clean-old:
    echo $SUDO_PASS | sudo -S nix-collect-garbage --delete-old

# Lists all Nix Generations
[group('nix/utils')]
list:
   nixos-rebuild list-generations 

# Delete specified generations
[group('nix/utils')]
delete-generations +gen:
    echo $SUDO_PASS | sudo -S nix-env --profile /nix/var/nix/profiles/system --delete-generations {{gen}}

# Optimize and compresses nix store. This may take a long while.
[group('nix/utils')]
optimise:
    nix-store --optimise --verbose

# Searches through all files for TODO:
[group('utils')]
todo:
    rg -g '!Justfile' -g '!todo.md' -i "TO-?DO"

[group('sops')]
edit-sops:
    sops edit secrets/example.yaml

_git-add:
    @git add .
    
