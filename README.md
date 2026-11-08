# base-containers

Early container stages to serve as a foundation for application containers.


## Development


### Dependencies

1. Install Docker ([Get Docker | Docker Docs][docker-install])
2. Install addititional dependencies
   macOS installation example:
   ```shell
   brew install hadolint prek railway rsync shellcheck
   ```
   1. Install hadolint ([Install - hadolint/hadolint][hadolint-install])
   2. Install prek ([Installation - j178/prek][prek-install])
   3. Install Railway CLI ([Installing - CLI | Railway Docs][railway-install])
   4. Install Rsync ([rsync download][rsync-install])
   5. Install shellcheck ([Installing -
      koalaman/shellcheck][shellcheck-install])

[docker-install]: https://docs.docker.com/get-started/get-docker/
[hadolint-install]: https://github.com/hadolint/hadolint#install
[prek-install]: https://github.com/j178/prek#installation
[railway-install]: https://docs.railway.com/cli#installing-the-cli
[rsync-install]: https://rsync.samba.org/download.html
[shellcheck-install]: https://github.com/koalaman/shellcheck#installing


## Setup

1. Prepare and install prek Git hooks:
   ```shell
   prek install --prepare-hooks
   ```
2. Create the enviornment `.env` file by copying
   [`.env.example`](.env.example):
    ```shell
    cp .env.example .env
    ```
2. Update `.env` to ensure all variable have appropriate values.
3. Build Docker Compose services:
    ```shell
    docker-compose build
    ```


### Static analysis

Analysis on git commit is configure in Setup, step 1, above.

Prek can be invoked manually:
```shell
prek run --show-diff-on-failure --color=always --all-files
```


## License

[![CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
button][cc-zero-png]][cc-zero]

[`LICENSE`](LICENSE): The contents of this repository are dedicated to the
public domain under the [CC0 1.0 Universal (CC0 1.0) Public Domain
Dedication][cc-zero].

[cc-zero-png]: https://licensebuttons.net/l/zero/1.0/88x31.png "CC0 1.0 Universal badge"
[cc-zero]: https://creativecommons.org/publicdomain/zero/1.0/ "CC0 1.0 Universal - Creative Commons"
