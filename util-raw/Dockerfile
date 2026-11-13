# https://docs.docker.com/engine/reference/builder/

# https://gunicorn.org/guides/docker/
# hadolint ignore=DL3007
FROM ghcr.io/benoitc/gunicorn:latest

# https://docs.docker.com/build/building/best-practices/#apt-get
# - Retrieve new lists of packages, distribution upgrade, install new
#   packages, erase downloaded archive files, and erase package lists
USER root
RUN set -o errexit -o nounset \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
        --no-allow-insecure-repositories --quiet \
    && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade \
        --no-install-recommends --no-install-suggests --quiet --yes \
    && DEBIAN_FRONTEND=noninteractive apt-get install \
        --no-install-recommends --no-install-suggests --quiet --yes \
        dumb-init \
    && DEBIAN_FRONTEND=noninteractive apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/*
USER gunicorn

WORKDIR /app
COPY --chown=gunicorn:gunicorn app.py .
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "app:app"]
