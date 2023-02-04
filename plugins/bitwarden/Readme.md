# Bitwarden
Bitwarden-cli integration with easier `list` and `unlock` commands.

## Requirements
* [Bitwarden CLI installed](https://github.com/bitwarden/clients/tree/master/apps/cli)
* [fzf](https://github.com/junegunn/fzf)

## Usage
### List
`bitwarden list` : List all items from your vault.
`bitwarden list <search>` : List items by using a pre-filter.

### Unlock
`bitwarden unlock` : Unlock your vault and add the session key in your environment variable

Other commands are forwarded to default `bw` command.
Ex: `bitwarden login --sso` will trigger `bw login --sso` 
