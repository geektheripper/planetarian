# Planetarian

planetarian's linux shell environment

## Install

```bash
# new cloud machine
curl -fsSL https://raw.githubusercontent.com/geektheripper/planetarian/master/init.sh | bash -s -- https://raw.githubusercontent.com/geektheripper/planetarian/master/config-template.json

# install planetarian
sudo apt-get install -y curl git
curl -fsSL https://raw.githubusercontent.com/geektheripper/planetarian/master/install.sh | bash -s -- https://raw.githubusercontent.com/geektheripper/planetarian/master/config-template.json
```

## Config

```bash
i config <set|del|get|add|remove> <scope> <key> [value]
# cached read
i config cread <scoop> <key> <message>
i switch <scope> <key> [on|off]
```

## Network

```bash
i ipv6 [on|off]
```

## Self Management

```bash
i reload
i upadte
```

## Proxy

```bash
i proxy set http://host:port
i proxy set-default http://host:port
i proxy unset
i proxy autoload on
i proxy autoload off
i proxy no-proxy add
i proxy no-proxy remove
i proxy set-docker
i proxy unset-docker
```

## Docker

```bash
i docker set-proxy [http://host:port]
```

## NodeJS

```bash
i node install
i node install-node [version]
i node install-yarn [version]
```

## Secret

```bash
# init secret drive, install vault
# and open autoload secret switch
i secret install

# valut
i vault set-host [host]
i vault set-user [user]
i vault login
i vault json <path/to/secret>
# get json format secret

# env utils
i vault env pair <path/to/secret>
# => "FOO=1 BAR=2"
# eval "$(i vault env pair path/to/secret) run some command"
i vault env load <path/to/secret>
# eval "FOO=1 BAR=2"
i vault env export <path/to/secret>
# eval "export FOO=1 BAR=2"
i vault env unset <path/to/secret>
# eval "unset FOO BAR"
# eval "export FOO BAR"
i vault env envsubst <path/to/secret>
# i vault env envsubst path/to/secret <config.tmpl.json >config.json
```

## Random

```bash
i rnd string <charset> <length>
# ts>r<>sehctce>rsat>tash<<ee<ac>rt<hat>>het
i rnd alpha [length]
# ugLjfsuzPVBaPIig
i rnd alnum [length]
# AXYfbJ8oRZuTtYb7
i rnd passwd [length]
# lFdLBuUErFU62niC
i rnd sqpass [length]
# hc[(U3B3YBr^05,M
```

## SSH

```
~/.ssh/keys -> /run/planetarian/secret/ssh/keys
|-- <collection name>
|   |-- <key name>
|   `-- ...
`-- ...

~/.ssh/config.d -> /run/planetarian/secret/ssh/config.d
|-- <collection name>
`-- ...
```

```bash
# pull all keys and config from vault
i ssh sync

# push/pull a collection to vault
# includes config and keys
i ssh push <collection>
i ssh pull <collection>

# create a key and push to vault
i ssh create <collection> <key>

# print public key
i ssh get pk <collection> <key>
# print fingerprints fo a key
i ssh get fp <collection> <key>
```

## ACME

```bash
# install acme.sh
i acme install

# issue or renew a cert
i acme req <provider> <domain> [...alt domains]

# remove local cert
i acme rm <domain>

# remove remote cert
i acme remote-rm <domain>

# apply cert to target
i acme apply <target> [...target options]
i acme apply console <domain>
i acme apply esxi <domain> <server>

# show cert
# alias to "i acme apply console <domain>"
i acme show <domain>
```

## Environment based credentials

```bash
i env aliyun [account]
i env aws [account] [default_region]
i env minio [server] [user_name]
i env misc <path>
```

## Install

`i install <item>`

| key             | description                                      |
| --------------- | ------------------------------------------------ |
| `git`           | set git user email and defaultBranch             |
| `vscode-remote` | set zsh as default shell                         |
| `zsh`           | install oh-my-zsh and pure theme                 |
| `shellcheck`    | -                                                |
| `docker`        | install docker, docker-compose and aliyun mirror |
| `node`          | alias to `i node install`                        |
| `daily`         | daily applications for geektr                    |
| `minio`         | -                                                |
| `hclfmt`        | -                                                |
| `terraform`     | -                                                |
| `azure-cli`     | -                                                |
| `bdpcs`         | install qjfoidnh/BaiduPCS-Go                     |

## Todo

- [ ] load-config: `planetarian.init.node.version`
- [ ] use `cubbyhole` to save user secret
