#!/bin/bash
##
## script for restarting Minecraft Bedrock server running on tmux
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

execute-command "tellraw @a {\"rawtext\":[{\"text\":\"§c[SERVER]§a Restarting server in 5 seconds.\"}]}"
echo "Preparing to restart mc server..."
sleep 2
execute-command "tellraw @a {\"rawtext\":[{\"text\":\"§c[SERVER]§a Restarting...\"}]}"
sleep 1
execute-command stop
echo "Sending stop to minecraft server..."
sleep 2
echo "Starting minecraft server..."
tmux new -d -s minecraft-server ./start