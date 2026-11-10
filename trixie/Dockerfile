# https://docs.docker.com/engine/reference/builder/
#
# Base operating system image

# https://hub.docker.com/_/debian
FROM debian:trixie-slim

# Exclude paths in dpkg to preempt cleanup
COPY dpkg-cfg-runit-slim /etc/dpkg/dpkg.cfg.d/runit-slim
COPY apt-pref-runit-slim /etc/apt/preferences.d/runit-slim

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
        ca-certificates \
        msmtp-mta \
        runit-init \
        socklog-run \
    && DEBIAN_FRONTEND=noninteractive apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/* \
    && update-ca-certificates

# Runit configuration
#
# `rm -f /usr/sbin/policy-rc.d` reverts:
# https://github.com/debuerreotype/debuerreotype/blob/e63dab169190cd9403d77c6a87469fa0f153b659/scripts/debuerreotype-minimizing-config#L27-L37
#
# The default-syslog service is handled specially by runit (packages has
# related triggers). It can't be excluded and must be added before it can be
# removed.
RUN set -o errexit -o nounset \
    && touch \
        /etc/runit/native.boot.run \
        /etc/runit/no.emulate.sysv \
    && rm -rf \
        /usr/sbin/policy-rc.d \
        /etc/sv/socklog-unix/log \
    && ln -s /proc/1/fd/1 /etc/sv/socklog-unix/log \
    && update-service --add socklog-unix \
    && update-service --add default-syslog \
    && update-service --remove default-syslog
COPY --parents conf.d/* color_vars.sh /etc/container/
COPY --chmod=0555 setup.sh /etc/runit/boot-run/
ENTRYPOINT ["/usr/sbin/runit-init"]
# ⚠️  NOTE: CMD is ignored. Services must be installed and enabled per runit.
