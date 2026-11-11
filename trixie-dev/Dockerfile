# https://docs.docker.com/engine/reference/builder/

# hadolint ignore=DL3006
FROM trixie

# https://docs.docker.com/build/building/best-practices/#apt-get
# - Resynchronize the package index, update packages, install packages,
#   and clean-up apt/dpkg
RUN set -o errexit -o nounset \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
        --no-allow-insecure-repositories --quiet \
    && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade \
        --no-install-recommends --no-install-suggests --quiet --yes \
    && DEBIAN_FRONTEND=noninteractive apt-get install \
        --no-install-recommends --no-install-suggests --quiet --yes \
        curl \
        httpie \
        less \
        ripgrep \
        tree \
        vim \
        wget \
    && DEBIAN_FRONTEND=noninteractive apt-get clean --quiet

# Create a Sleep service
COPY --chmod=0555 sleep-run /etc/sv/sleep/run

RUN set -o errexit -o nounset \
    && mkdir --parents /etc/sv/sleep/log \
    && ln -s /etc/sv/socklog-unix/log/run /etc/sv/sleep/log/run \
    && update-service --add sleep
