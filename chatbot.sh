#!/usr/bin/env bash

# This is a small (and arguably stupid) chatbot that answer you
# about my public repository. You can also ask about other repositories.
# It uses the GitHub API to list public repositories. The information
# of the API can be found at https://developer.github.com/v3/repos/

# This is a part of the Unix Workbench MOOC on Coursera.

# It supports:
# "Help me!"
# "How many repos do I have?"
# "What are the repos that I have?"
# "How many repo does :username have?"
# "What are the repos that :username have?"

list_repo () {
  curl -s http://api.github.com/users/${1}/repos | jq -r '[].name'
}

count_repo () {
  list_repo $1 | wc -l | tr -d ' '
}

echo_help() {
  echo '"How many repos do I have?"'
  echo '"What are the repos that I have?"'
  echo '"How many repos does :username have?"'
  echo '"What are the repos that :username have?"'
}

echo 'This is a GitHub repo chatbot.'
echo 'Type `help` for help page, or `quit` to quit.'
while :
do
  echo 'How can I help you?'
  read -e input
  [[ $input == *"help"* ]] && help=true || help=false
  [[ $input == *"what"* ]] && what=true || what=false
  [[ $input == *"how"*  ]] && how=true  || how=false
  [[ $input == *"I"* ]]    && me=true   || me=false
  
  # Get the username
  if $me
  then
    username=ssantichaivekin
  # TODO : edit this after learning how to use SED
  else
    username=thisisnotausername
  fi

  if $help
  then
    echo_help
  elif $what
  then
    list_repo $username
  elif $how
  then
    count_repo $username
  else
    break
  fi
done
