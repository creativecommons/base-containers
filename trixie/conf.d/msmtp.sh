#!/bin/sh
# Comptabile with Dash (the Debian Almquist shell)
#
# This file is sourced by /etc/runit/boot-run/setup.sh
# (It shouldn't be executed directly)

_APP='msmtp'
print_bold 'Begin configuration'

_REQ_VARS='
    MSMTP_FROM_EMAIL
    MSMTP_MAILNAME
    MSMTP_ROOT_EMAIL
    MSMTP_SERVER_HOST
    MSMTP_SERVER_PASSWORD
    MSMTP_SERVER_USER
'
require_vars
unset _REQ_VARS

print_msg 'Configure /etc/mailname'
if [ "${MSMTP_MAILNAME}" = 'docker' ] && [ -n "${HOSTNAME}" ]
then
    MSMTP_MAILNAME="docker-${HOSTNAME}"
fi
echo "${MSMTP_MAILNAME}" > /etc/mailname

print_msg 'Configure /etc/aliases'
echo "\
# https://manpages.debian.org/trixie/msmtp/msmtp.1.en.html#aliases
default: ${MSMTP_ROOT_EMAIL}" > /etc/aliases

print_msg 'Create /var/log/msmtp.log'
touch /var/log/msmtp.log

print_msg 'Configure /etc/msmtprc'
echo "\
# https://manpages.debian.org/trixie/msmtp/msmtp.1.en.html
account smarthost
host ${MSMTP_SERVER_HOST}
port 587
# %M will be replaced by the contents of /etc/mailname
domain %M
auth on
user ${MSMTP_SERVER_USER}
password ${MSMTP_SERVER_PASSWORD}
tls on
from ${MSMTP_FROM_EMAIL}
set_from_header on
logfile /var/log/msmtp.log
syslog off
aliases /etc/aliases
account default : smarthost" > /etc/msmtprc

print_bold 'End configuration  '
unset _APP
