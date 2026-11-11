# CC Debian trixie

Creative Commons (CC) Debian 13 (trixie) Docker base image


## Overview

The goal of the CC Debian trixie base image is to provide a consistent platform
for application images.

- **Docker `FROM` image:** [`debian:trixie-slim`][docker-trixie]
- **Docker `ENTRYPOINT`:** `/usr/sbin/runit-init`
- **Docker `CMD`:** _unset, ignored_
- **Notable inclusions:**
  - `msmtp` to allow sending emails
  - `runit` to manage processes (init)
  - `socklog` to send syslog messages to init stdout (docker log)
- **Required variables:**
  - `MSMTP_FROM_EMAIL`
  - `MSMTP_MAILNAME`
  - `MSMTP_ROOT_EMAIL`
  - `MSMTP_SERVER_HOST`
  - `MSMTP_SERVER_PASSWORD`
  - `MSMTP_SERVER_USER`

> [!NOTE]
> `CMD` is ignored by this image. Instead service(s) must be installed and
> enabled per runit.

[docker-trixie]: https://hub.docker.com/_/debian


## Configuration

When the image starts up, the `/etc/runit/boot-run/setup.sh`
([`setup.sh`](setup.sh)) script does three important things:
1. Provides helper functions and variables
2. Sources configurations scripts in `/etc/container/conf.d/` that end with
   `.sh`



### Configuration scripts

- [`conf.d/msmtp.sh`](conf.d/msmtp.sh)


### Services


## Deployment

The image is deployed via GitHub Actions to the GitHub Container Registry
(GHCR). See the workflow for details:
[`../.github/workflows/build_trixie_to_ghcr.yml`][build].

[build]: ../.github/workflows/build_trixie_to_ghcr.yml


## Extending

Application images that use this image (`FROM docker pull
ghcr.io/creativecommons/trixie:latest`) can provide configuration files and
_must_ add a service instead of using `CMD`.


### Application configuration

Application docker images can include their own `conf.d/` scripts and specify
the application executable via the Docker `CMD`.

Configuration scripts _must_ be writtin for Dash (the Debian Almquist shell).
Using a `#!/bin/sh` shebang will ensure Shellcheck issues warnings about syntax
that is not compliant with POSIX.
- [dash(1) — dash — Debian buster — Debian Manpages][man-dash]

[man-dash]: https://manpages.debian.org/buster/dash/dash.1.en.html


### Application services

Runit service related documentation:
- [How do I create a new service directory - runit - frequently asked
  questions][runit-create]
- [Service Directories - Services and Daemons - runit - The Void Linux
  Handbook][void-services]
- [runsv(8) — runit — Debian trixie — Debian Manpages][man-runsv]

[runit-create]: https://smarden.org/runit/faq#create
[void-services]: https://docs.voidlinux.org/config/services/index.html#service-directories
[man-runsv]: https://manpages.debian.org/trixie/runit/runsv.8.en.html


## Additional references


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
