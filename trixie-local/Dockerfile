# https://docs.docker.com/engine/reference/builder/

# hadolint ignore=DL3006
FROM trixie

# https://docs.docker.com/build/building/best-practices/#apt-get
# - apt and dpkg are configured in parent CC Debian trixie image
# - Retrieve new lists of packages, distribution upgrade, install new
#   packages, erase downloaded archive files, and erase package lists
RUN set -o errexit -o nounset \
    && apt-get update --quiet \
    && apt-get dist-upgrade --quiet --yes \
    && apt-get install --quiet --yes \
        curl \
        httpie \
        less \
        ripgrep \
        tree \
        vim \
        wget \
    && apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/*

# Create a Sleep service
COPY --chmod=0555 sleep-run /etc/sv/sleep/run
RUN set -o errexit -o nounset \
    && mkdir --parents /etc/sv/sleep/log \
    && ln -s /etc/sv/socklog-unix/log/run /etc/sv/sleep/log/run \
    && update-service --add sleep
