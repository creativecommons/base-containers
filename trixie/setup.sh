#!/bin/sh
# shellcheck disable=SC1090,SC1091
# Comptabile with Dash (the Debian Almquist shell)
set -o errexit
set -o nounset

. /etc/container/color_vars.sh

#### FUNCTIONS ################################################################

print_bold() {
    # Each application configuration script is expected to set _APP at the
    # beginning and unset it at the end.
    if [ -n "${_APP:-}" ]
    then
        _app="${_APP}: "
    fi
    _color="${E97}"
    _datetime="$(date --utc '+%F %T.%N %Z')"
    _msg="${1}"
    printf "${_color}${_app:-}%s${E0} ${E90}%s${E0}\n" "${_msg}" "${_datetime}"
    unset _color _datetime _msg
}

print_error() {
    # Each application configuration script is expected to set _APP at the
    # beginning and unset it at the end.
    if [ -n "${_APP:-}" ]
    then
        _app="${_APP}: "
    fi
    _color="${E31}"
    _msg="${1}"
    printf "${_color}${_app:-}%s${E0}\n" "${_msg}"
    unset _color _msg
}

print_msg() {
    # Each application configuration script is expected to set _APP at the
    # beginning and unset it at the end.
    if [ -n "${_APP:-}" ]
    then
        _app="${_APP}: "
    fi
    _msg="${1}"
    printf "${_app:-}%s\n" "${_msg}"
    unset _app _msg
}

require_vars() {
    # Ensure all specified variables are present
    #
    # Each application configuration script is expected to set _REQ_VARS before
    # calling this function and unset it afterwards.
    _error_exit=
    for _variable in ${_REQ_VARS}
    do
        if env | { ! grep --quiet "^${_variable}=."; }
        then
            print_error "Environment variable required: ${_variable}"
            _error_exit=yes
        fi
    done
    if [ -n "${_error_exit}" ]
    then
        print_error 'Halting due to missing environment variable(s)'
        # https://manpages.debian.org/trixie/runit/runit.8.en.html
        # If /etc/runit/1 crashes, or exits 100, runit will skip stage 2 and
        # enter stage 3.
        exit 100
    fi
    unset _error_exit
}

#### MAIN #####################################################################

# Read and execute commands from all configuration scripts in the current shell
# environment and return the last command executed from that configuration
# script
for _config_script in /etc/container/conf.d/*.sh
do
    [ -f "${_config_script}" ] || continue
    . "${_config_script}"
done
