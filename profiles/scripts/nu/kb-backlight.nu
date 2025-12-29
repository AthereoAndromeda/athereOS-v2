#!/usr/bin/env nu

const KB_BACKLIGHT_DIR = '/sys/devices/pci0000:00/0000:00:14.3/PNP0C09:00/VPC2004:00/leds/platform::kbd_backlight/' | path parse
const KB_BACKLIGHT_LVL_PATH = $KB_BACKLIGHT_DIR | path join "brightness"

def "main get" [] {
  let led_lvl: int = open $KB_BACKLIGHT_LVL_PATH | into int
  echo $led_lvl
}

def main [] {
}
