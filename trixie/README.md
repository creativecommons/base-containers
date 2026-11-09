# trixie

Creative Commons (CC) Debian 13 (trixie) Docker base image


## Overview

The goal of the  `trixie` base image is to provide a consistent platform for
application images.

- **Docker `FROM` image:** [`debian:trixie-slim`][docker-trixie]
- **Docker `ENTRYPOINT`:** [`entrypoint.sh`](entrypoint.sh)
  - In image: `/srv/container/entrypoint.sh`
- **Docker `CMD`:** _unset_
- **Notable inclusions:**
  - `msmtp` to allow sending emails
- **Required variables:**
  - `MSMTP_FROM_EMAIL`
  - `MSMTP_MAILNAME`
  - `MSMTP_ROOT_EMAIL`
  - `MSMTP_SERVER_HOST`
  - `MSMTP_SERVER_PASSWORD`
  - `MSMTP_SERVER_USER`

[docker-trixie]: https://hub.docker.com/_/debian


## Configuration

When the image starts up, the [`entrypoint.sh`](entrypoint.sh) script does
three important things:
1. Provides helper functions and variables
2. Sources configurations scripts in `/srv/container/conf.d/` that end with
   `.sh`
3. Executes the Docker `CMD` (_if_ it is set)

Application images can include their own `conf.d/` scripts and specify the
application executable via the Docker `CMD`.


### Configuration scripts

- [`conf.d/msmtp.sh`](conf.d/msmtp.sh)


## Deployment

The image is deployed via GitHub Actions to the GitHub Container Registry
(GHCR). See the workflow for details:
[`../.github/workflows/build_trixie_to_ghcr.yml`][build].

[build]: ../.github/workflows/build_trixie_to_ghcr.yml


## References


### Debian

- [debian - Official Image | Docker Hub][docker-trixie]
- [Release Notes for Debian 13 (trixie) — release-notes
  documentation][trixie-release]

[docker-trixie]: https://hub.docker.com/_/debian
[trixie-release]: https://www.debian.org/releases/trixie/release-notes/index.en.html


### msmtp

- [msmtp - about][msmtp]
  - [msmtp manual in HTML format][msmtp-man]
- [msmtp(1) — msmtp — Debian trixie — Debian Manpages][msmtp-debman]


[msmtp]: https://marlam.de/msmtp/
[msmtp-man]: https://marlam.de/msmtp/msmtp.html
[msmtp-debman]: https://manpages.debian.org/trixie/msmtp/msmtp.1.en.html
