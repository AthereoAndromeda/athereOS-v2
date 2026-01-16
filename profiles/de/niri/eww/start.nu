#!/usr/bin/env nu

def main [] {
  eww open status-bar -c .
  eww logs -c .
}

def "main logs" [] {
  eww logs -c .
}

def "main kill" [] {
  eww kill -c .
}

def "main restart" [] {
  main kill
  main
}
