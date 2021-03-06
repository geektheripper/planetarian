#!/usr/bin/env bash

planetarian::secret::vault::init() {
  planetarian::init vault
}

planetarian::secret::vault::clear() {
  unset VAULT_ADDR
  unset VAULT_USER
  rm -f ~/.vault-token
}

planetarian::secret::vault::load() {
  VAULT_ADDR=$(planetarian::config get secret vault_addr 2>/dev/null)
  VAULT_ADDR=${VAULT_ADDR:-"https://vault.geektr.co"}
  export VAULT_ADDR
}

planetarian::secret::vault::login() {
  planetarian::secret::vault::load

  VAULT_USER=$(planetarian::config get secret vault_user 2>/dev/null)
  VAULT_USER=${VAULT_USER:-"planetarian"}

  vault token revoke -self 2>/dev/null
  unset VAULT_TOKEN
  vault login -no-print -method=userpass username="$VAULT_USER"
  VAULT_TOKEN=$(vault token lookup --format json | jq -r '.data.id')
  export VAULT_TOKEN
}

planetarian::secret::vault::su() {
  echo -n "root token: "
  read -rs VAULT_TOKEN
  export VAULT_TOKEN
}

planetarian::secret::vault::set_host() {
  planetarian::config set secret vault_addr "$1"
  planetarian::secret::vault::clear
  planetarian::secret::vault::load
}

planetarian::secret::vault::set_user() {
  planetarian::secret::vault::clear
  planetarian::config set secret vault_user "$1"
  planetarian::secret::vault::login
}

planetarian::feature_switch secret autoload && planetarian::secret::vault::load

planetarian::command "vault set-host" planetarian::secret::vault::set_host
planetarian::command "vault set-user" planetarian::secret::vault::set_user
planetarian::command "vault login" planetarian::secret::vault::login
planetarian::command "vault su" planetarian::secret::vault::su
