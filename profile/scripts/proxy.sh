#!/usr/bin/env bash

planetarian::proxy::get-proxy() {
  if [ -n "$1" ]; then
    echo "$1"
    return 0
  fi

  # shellcheck disable=SC2153
  if [ -n "$PLTR_PROXY" ]; then
    echo "$PLTR_PROXY"
    return 0
  fi

  planetarian::config proxy:url read 2>/dev/null
}

planetarian::proxy::get-no-proxy() {
  # shellcheck disable=SC2153
  if [ -n "$PLTR_NO_PROXY" ]; then
    echo "$PLTR_NO_PROXY"
    return 0
  fi

  planetarian::config proxy:no-proxy read 2>/dev/null || true
}

planetarian::proxy::load-default() {
  proxy=$(planetarian::proxy::get-proxy)
  if [ -n "$proxy" ]; then
    export DEFAULT_PROXY=$proxy
  fi
}

planetarian::proxy::set-default() {
  planetarian::config proxy:url write "$1"
}

# shellcheck disable=SC2120
planetarian::proxy::set() {
  _proxy=$(planetarian::proxy::get-proxy "$1")
  echo "set proxy to: $_proxy"
  export all_proxy="$_proxy"
  export http_proxy="$_proxy"
  export https_proxy="$_proxy"
  export ftp_proxy="$_proxy"
  export ALL_PROXY="$_proxy"
  export HTTP_PROXY="$_proxy"
  export HTTPS_PROXY="$_proxy"
  export FTP_PROXY="$_proxy"

  _no_proxy=$(planetarian::proxy::get-no-proxy)
  if [ -n "$_no_proxy" ]; then
    echo "set no_proxy to: $_no_proxy"
    export no_proxy="$_no_proxy"
    export NO_PROXY="$_no_proxy"
  fi
}

planetarian::proxy::unset() {
  unset all_proxy
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  unset ALL_PROXY
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset FTP_PROXY
  unset no_proxy
  unset NO_PROXY
}

# add 192.168.1.1/24
# rm *.github.com
planetarian::proxy::no-proxy() {
  planetarian::config proxy:no-proxy set "$1" "$2"
}

planetarian::proxy::autoload() {
  planetarian::config proxy:autoload switch turn "$1"
}

planetarian::proxy::load-default
planetarian::config proxy:autoload switch test yes && planetarian::proxy::set

planetarian::proxy() {
  command="planetarian::proxy::$1"
  shift
  $command "$@"
}

planetarian::command proxy planetarian::proxy
