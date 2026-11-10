#!/bin/bash
# shellcheck disable=SC2034
# Comptabile with Dash (the Debian Almquist shell)
#
# This file is sourced by /etc/runit/boot-run/setup.sh
# (It shouldn't be executed directly)

# https://en.wikipedia.org/wiki/ANSI_escape_code
E0="$(printf "\e[0m")"        # reset
E30="$(printf "\e[30m")"      # foreground: black
E31="$(printf "\e[31m")"      # foreground: red
E32="$(printf "\e[32m")"      # foreground: green
E33="$(printf "\e[33m")"      # foreground: yellow
E34="$(printf "\e[34m")"      # foreground: blue
E35="$(printf "\e[35m")"      # foreground: magenta
E36="$(printf "\e[36m")"      # foreground: cyan
E37="$(printf "\e[37m")"      # foreground: white
E40="$(printf "\e[40m")"      # background: black
E41="$(printf "\e[41m")"      # background: red
E42="$(printf "\e[42m")"      # background: green
E43="$(printf "\e[43m")"      # background: yellow
E44="$(printf "\e[44m")"      # background: blue
E45="$(printf "\e[45m")"      # background: magenta
E46="$(printf "\e[46m")"      # background: cyan
E47="$(printf "\e[47m")"      # background: white
E90="$(printf "\e[90m")"      # foreground: bright black (gray)
E91="$(printf "\e[91m")"      # foreground: bright red
E92="$(printf "\e[92m")"      # foreground: bright green
E93="$(printf "\e[93m")"      # foreground: bright yellow
E94="$(printf "\e[94m")"      # foreground: bright blue
E95="$(printf "\e[95m")"      # foreground: bright magenta
E96="$(printf "\e[96m")"      # foreground: bright cyan
E97="$(printf "\e[97m")"      # foreground: bright white
E100="$(printf "\e[100m")"    # background: bright black (gray)
E101="$(printf "\e[101m")"    # background: bright red
E102="$(printf "\e[102m")"    # background: bright green
E103="$(printf "\e[103m")"    # background: bright yellow
E104="$(printf "\e[104m")"    # background: bright blue
E105="$(printf "\e[105m")"    # background: bright magenta
E106="$(printf "\e[106m")"    # background: bright cyan
E107="$(printf "\e[107m")"    # background: bright white
