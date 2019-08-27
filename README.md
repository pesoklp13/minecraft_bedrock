# Scripts for minecraft bedrock server using tmux

Available scripts for minecraft bedrock server:

* [start](#start)
* [start-server](#start-server)
* [stop-server](#stop-server)
* [restart-server](#restart-server)
* [say](#say)
* [update-server](#update-server)

## start

Script for start bedrock server

## start-server

Script which run start script inside tmux instance

## stop-server

Script for shut down already running server in tmux instance

## restart-server

Script for restart bedrock server running inside tmux instance

## say 

Echo message into bedrock server running inside tmux instance

## update-server

Script for update bedrock server using sources from [download](https://minecraft.net/en-us/download/server/bedrock/).

Script parts:

* [checking version](#checking-version)
* [filesystem preparation](#filesystem-preparation)
* [backup & download new version](#backup--download-new-version)

### checking version

Because there are two versions (Windows & Linux) script is checking available version from parsing anchor element.

### filesystem preparation

Script will check if exist folders for server & download and will create it if not.

Default path of server is `${HOME}/minecraft` and current version of bedrock server is downloaded in default path `${HOME}/downloads/minecraft`

If you would like to use your own path you can run the script with defined global variables:

* `MINECRAFT_SERVER` - path to server
* `MINECRAFT_DOWNLOAD` - path to download folder

### backup & download new version

If new version exists it's downloaded a `server.properties` file will be backuped and set after all files copied.

This script will leave all specific folders like `worlds`, `structers` or `treatmens` as is. 
