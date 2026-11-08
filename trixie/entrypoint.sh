#!/bin/bash
# shellcheck disable=SC1090,SC1091
set -o errexit
set -o errtrace
set -o nounset

# shellcheck disable=2154
trap '_es=${?};
    printf "${0}: line ${LINENO}: \"${BASH_COMMAND}\"";
    printf " exited with a status of ${_es}\n";
    exit ${_es}' ERR

#### FUNCTIONS ################################################################

error_exit() {
    local _msg
    _msg="${1}"
    printf "${E31}ERROR: %s${E0}" "${_msg}" 1>&2
    # Use exit code 0 to avoid triggering restart: on-failure
    exit 0
}

print_bold() {
    # Each application configuration script is expected to set _APP at the
    # beginning and unset it at the end.
    local _app _color _datetime _msg
    if [[ -n "${_APP:-}" ]]
    then
        _app="${_APP}: "
    fi
    _color="${E97}"
    _datetime="$(date --utc '+%F %T.%N %Z')"
    _msg="${1}"
    printf "${_color}${_app:-}%s${E0} ${E90}%s${E0}\n" "${_msg}" "${_datetime}"
}

print_msg() {
    # Each application configuration script is expected to set _APP at the
    # beginning and unset it at the end.
    local _app _color _datetime _msg
    if [[ -n "${_APP:-}" ]]
    then
        _app="${_APP}: "
    fi
    _msg="${1}"
    printf "${_app:-}%s\n" "${_msg}"
}

require_vars() {
    # Ensure all specified variables are present
    #
    # Each application configuration script is expected to set _REQ_VARS before
    # calling this function and unset it afterwards.
    local _variable
    for _variable in "${_REQ_VARS[@]}"
    do
        if [[ -z "${!_variable:-}" ]]
        then
            error_exit "Required environment variable is not set: ${_variable}"
        fi
    done
}

#### MAIN #####################################################################

source /srv/container/color_vars.sh

# Read and execute commands from all configuration scripts in the current shell
# environment and return the last command executed from that configuration
# script
for _config_script in /srv/container/conf.d/*.sh
do
    [[ -f "${_config_script}" ]] || continue
    source "${_config_script}"
done

# Execute CMD, if present
if [[ -n "${1:-}" ]]
then
    print_bold 'Execute CMD'
    exec "${@}"
fi
