bitwarden() {  
  action="$1"
  if [ "$action" = "list" ] ;
  then
    # Override `bw list` command
    # Check if user is logged in before.
    eval "bw unlock --check"
    local last_error_code=$?
    if [ $last_error_code -eq 1 ] ;
    then
      echo "You're logged out. Please login by using 'bitwarden login' or 'bitwarden unlock'"
      return 1
    fi
    command="bw list items"
    if [ -v $2 ] ; 
    then
      command="${command} --search=$2"
    fi
    items=$(eval $command)
    if [ -z $items ] ; 
    then
      echo "No result."
      return 0
    fi
    local result=$(jq -r '.[] | "\(.name)\t\(.login)"' <<< "$items")
    local selected_cred=$(echo "$result" | fzf --preview='echo {} | cut -f2 | jq')
    local username=$(echo "$selected_cred" | cut -f2 | jq -r .username)
    local password=$(echo "$selected_cred" | cut -f2 | jq -r .password)
    echo "$password" | pbcopy
    echo "Username : ${username} | Password : <copied to clipboard>"
  else
    # Other bitwarden commands are forward to default bitwarden-cli
    if [ "$action" = "unlock" ] ;
    then
      session_key=$(eval "bw unlock --raw")
      export BW_SESSION=$session_key
    else
      eval "bw $@"
    fi
  fi
}
