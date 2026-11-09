# https://docs.docker.com/engine/reference/builder/
#
# Base operating system image

# https://hub.docker.com/_/debian
FROM debian:trixie-slim

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
    && DEBIAN_FRONTEND=noninteractive apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/* \
    && update-ca-certificates

# Startup configuration
COPY --parents conf.d/* color_vars.sh /srv/container/
COPY --chmod=0555 entrypoint.sh /srv/container/
ENTRYPOINT ["/srv/container/entrypoint.sh"]
