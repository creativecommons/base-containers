# https://docs.docker.com/engine/reference/builder/
#
# Base operating system image

# https://hub.docker.com/_/debian
FROM debian:trixie-slim

# Exclude paths in dpkg to preempt cleanup
COPY dpkg-cfg-socklog-slim /etc/dpkg/dpkg.cfg.d/socklog-slim

# https://docs.docker.com/build/building/best-practices/#apt-get
# - Resynchronize the package index, update packages, install packages,
#   clean-up apt/dpkg, and update CA certificates
RUN set -o errexit -o nounset \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
        --no-allow-insecure-repositories --quiet \
    && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade \
        --no-install-recommends --no-install-suggests --quiet --yes \
    && DEBIAN_FRONTEND=noninteractive apt-get install \
        --no-install-recommends --no-install-suggests --quiet --yes \
        dumb-init \
        ca-certificates \
        msmtp-mta \
        runit \
        socklog-run \
    && DEBIAN_FRONTEND=noninteractive apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/* \
    && update-ca-certificates

# Runit configuration
#
# The default-syslog service is handled specially by runit (packages has
# related triggers). It can't be excluded and must be added before it can be
# removed.
COPY --chmod=0555 log-run /etc/sv/socklog-unix/log/run
RUN set -o errexit -o nounset \
    && update-service --add socklog-unix \
    && update-service --add default-syslog \
    && update-service --remove default-syslog
COPY --parents conf.d/* color_vars.sh /etc/container/
COPY --chmod=0555 setup.sh /etc/container/
ENTRYPOINT ["/usr/bin/dumb-init", "/etc/container/setup.sh"]
# ⚠️  NOTE: CMD is ignored. Services must be installed and enabled per runit.
