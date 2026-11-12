# https://docs.docker.com/engine/reference/builder/
#
# Base operating system image

# https://hub.docker.com/_/debian
FROM debian:trixie-slim

# Exclude paths in dpkg to preempt cleanup
COPY dpkg-cfg-socklog-slim /etc/dpkg/dpkg.cfg.d/socklog-slim

# https://docs.docker.com/build/building/best-practices/#apt-get
# 1. Configure apt to avoid optional packages
# 2. Configure debconf to use noninteractive frontend
# 3. Retrieve new lists of packages, distribution upgrade, install new
#    packages, erase downloaded archive files, erase package lists, and update
#    certificate authority certificates
COPY docker-slim /etc/apt/apt.conf.d/docker-slim
RUN set -o errexit -o nounset \
    sed --regexp-extended --in-place \
        -e's/^(Templates:.+)$/\1\n# Debconf will select the default answer/' \
        -e's/(default answer)$/\1\nFrontend: noninteractive/' \
        /etc/debconf.conf \
    && apt-get update --quiet \
    && apt-get dist-upgrade --quiet --yes \
    && apt-get install --quiet --yes \
        dumb-init \
        ca-certificates \
        msmtp-mta \
        runit \
        socklog-run \
    && apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/* \
    && update-ca-certificates

# Runit configuration
# - The default-syslog service is handled specially by runit (packages has
#   related triggers). It can't be excluded and must be added before it can be
#   removed.
COPY --chmod=0555 log-run /etc/sv/socklog-unix/log/run
RUN set -o errexit -o nounset \
    && update-service --add socklog-unix \
    && update-service --add default-syslog \
    && update-service --remove default-syslog
COPY --parents conf.d/* color_vars.sh /etc/container/
COPY --chmod=0555 setup.sh /etc/container/

# Initialization
# 1. dumb-init is a signal repeater that defaults to process group mode
# 2. setup script sources any available configuration scripts
# 3. setup execs runit's runsvdir service management
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/etc/container/setup.sh"]
# ⚠️  NOTE: CMD is ignored. Services must be installed and enabled per runit.
