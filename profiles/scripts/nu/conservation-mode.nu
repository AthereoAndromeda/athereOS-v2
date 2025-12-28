#!/usr/bin/env nu

let cv_path = "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

def "main on" [] {
  "1" | sudo -A tee $cv_path
}

def "main off" [] {
  "0" | sudo -A tee $cv_path
}

def main [] {
  let is_cv = open $cv_path | into int

  if $is_cv == 1 {
    main off
  } else {
    main on
  }
}

