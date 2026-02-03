#!/usr/bin/env nu

# A manual "log2" using bit shifting
# Faster than nushell log
def fast-log2 [n: int] {
    mut val = $n
    mut count = 0
    while $val > 0 {
        $val = ($val | bits shr 1)
        $count += 1
    }
    $count
}

def get-occupied [bmask: int] {
  # Check positions 1 through 8 only, nushell does not support
  # 9 bit operations 
  let occupied_tags = 1..8 | where { |i| 
      ($bmask bit-and (1 | bits shl ($i - 1))) != 0 
  }

  return $occupied_tags
}

def get-current [bmask: int] {
  fast-log2 $bmask
}

def handle-tags [s: list<string>] {
  let occupied_tags = $s.0 | into int | get-occupied $in
  let current_tag = $s.1 | into int | get-current $in
  
  let rec = {
    occupied: $occupied_tags
    current: $current_tag
  }

  $rec | to json -r
}

def "main watch-keymode" [] {
  mmsg -w -b
    | lines
    | split words
    | each {|s|
      let keymode = $s | last
      print $keymode
    }
}

def "main watch-layout" [] {
  mmsg -w -l
    | lines
    | split words
    | each {|s|
      let layout = $s | last
      print $layout
    }
}

def "main get-current-layout" [] {
  mmsg -g -l | split words | last
}

def "main watch-tags" [] {

  let masks = mmsg -w -t
    | lines
    | split column " "
    | each {|n|
      if ($n.column2 == "tags") {
        # mmsg gives us two bitmasks, one decimal and one binary.
        # just process the decimal
        if ($n.column3 | str length) != 9 {
          print (handle-tags [$n.column3, $n.column4, $n.column5])
        }
      
      }

      
    }
}

def "main parse-bitmask" [] {  
  let masks = mmsg -g -t
    | lines
    | last 
    | split row " " 
    | skip 2
    | into int --radix 2

  return $masks
}

def "main get-occupied-tags" [] {
  let masks = main parse-bitmask
  let occupied_tags = $masks.0 

  get-occupied $occupied_tags
}

def "main get-current-tag" [] { 
  let masks = main parse-bitmask
  let active_tags = $masks.1 

  # WARN: We are assuming the active_tags bitmask holds only a single ONE
  # This assumption may fail with multiple monitors. or maybe not idk 
  # 
  # PERF: Nushell does not have count_leading_zeros sadly
  let current_tag = (get-current $active_tags)
  echo $current_tag
}



def "main tag-num" [] {
  let lines = mmsg -g -t | split row "\n"
  let tags = $lines | take 9

  let tag = $tags | take 1
  let t = $tag | split row " "
  let rec = {
    monitor: $t.0
    pos: $t.2
    state: $t.3
    clients_num: $t.4
  }
  
  echo $t
}

def determine-type [str: list<string>] {
  if ($str | length) == 6 {
    # parse-tag $str
  } else if ($str | length) == 5 {
    
  }
}

# Watch the mmsg
def main [] {
  mmsg -w
    | lines
    | split column " "
    | each {|m|
      print $m
      determine-type $m
    }
}
