#!/usr/bin/env bash

delete_subvolume_recursively() {
  IFS=$'\n'
  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
      delete_subvolume_recursively "$i"
  done
  btrfs subvolume delete "$1"
}

delete_subvolume_recursively "$1"
