#!/usr/bin/env nu

let cv_path = "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

def "main on" [] {
  "0" | sudo tee $cv_path
}

def "main off" [] {
  "1" | sudo tee $cv_path
}

def main [] {
  let is_cv = open $cv_path | into int

  if $is_cv == 1 {
    main on
  } else {
    main off
  }
}

