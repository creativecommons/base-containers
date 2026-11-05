# base-containers

Early container stages to serve as a foundation for application containers.


## Development


### Setup

1. Install Docker ([Get Docker | Docker Docs][get-docker])
2. Install hadolint ([Install - hadolint/hadolint][hadolint-install])
3. Install shellcheck ([Installing - koalaman/shellcheck][shellcheck-install])
4. Install prek ([Installation - j178/prek][prek-install])
5. Prepare and install prek Git hooks:
   ```shell
   prek install --prepare-hooks
   ```

[get-docker]: https://docs.docker.com/get-started/get-docker/
[hadolint-install]: https://github.com/hadolint/hadolint#install
[shellcheck-install]: https://github.com/koalaman/shellcheck#installing
[prek-install]: https://github.com/j178/prek#installation


### Static analysis

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
