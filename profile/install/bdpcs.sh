#!/usr/bin/env bash

. "$HOME/.planetarian/profile/planetarian-install.sh"

planetarian::install::utils::require-proxy
planetarian::install::utils::cd-tempdir

version=$(planetarian::install::utils::github-latest-ver qjfoidnh/BaiduPCS-Go)

wget -O bdpcs.zip "https://github.com/qjfoidnh/BaiduPCS-Go/releases/download/v$version/BaiduPCS-Go-v$version-linux-amd64.zip"
unzip bdpcs.zip

planetarian::install::utils::place-binary "BaiduPCS-Go-$version-linux-amd64/BaiduPCS-Go" bdpcs
