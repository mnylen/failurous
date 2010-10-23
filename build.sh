#!/bin/bash -x
[[ -s ".rvmrc" ]] && source .rvmrc
bundle install
rspec .

