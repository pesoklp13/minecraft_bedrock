#!/bin/bash
##
## script to print message in Minecraft Bedrock server running on tmux
## Created by Animator
##

tmuxName=minecraft-server

if ! tmux ls | grep -q "$tmuxName"; then
    echo "No tmux with name $tmuxName is running. Exitting."
    exit
fi

execute-command () {
  local COMMAND=$1
  if [[ $tmuxName != "" ]]; then
    tmux send-keys -t $tmuxName "$COMMAND$(printf \\r)"
  fi
}
execute-command "tellraw @a {\"rawtext\":[{\"text\":\"§c[SERVER]§a $1\"}]}"