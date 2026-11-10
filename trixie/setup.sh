#!/bin/sh
# shellcheck disable=SC1090,SC1091
# Comptabile with Dash (the Debian Almquist shell)
set -o errexit
set -o nounset

. /etc/container/color_vars.sh

#### FUNCTIONS ################################################################

error_exit() {
    _msg="${1}"
    printf "${E31}ERROR: %s${E0}" "${_msg}" 1>&2
    unset _msg
    exit 1
}

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
    for _variable in ${_REQ_VARS}
    do
        if env | { ! grep --quiet "^${_variable}=."; }
        then
            error_exit "Required environment variable is not set: ${_variable}"
        fi
    done
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

# Execute CMD, if present
if [ -n "${1:-}" ]
then
    print_bold 'Execute CMD'
    exec "${@}"
fi
