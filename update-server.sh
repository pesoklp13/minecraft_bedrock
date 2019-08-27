#!/bin/sh
##
## Automated Minecraft Bedrock Server Updater for Linux
## Created by Pesok inspired by Phosix
##

# ${SERVER} The directory holding your Bedrock server files
if [ -z ${MINECRAFT_SERVER} ]; then
    MINECRAFT_SERVER=${HOME}/minecraft
    echo "using default server path ${MINECRAFT_SERVER}"
fi

# The directory where you want the server software downloaded to
if [ -z ${MINECRAFT_DOWNLOAD} ]; then
    MINECRAFT_DOWNLOAD=${HOME}/downloads/minecraft
    echo "using default download path ${MINECRAFT_DOWNLOAD}"
fi

# The Minecraft Bedrock Server download page
# If Minecraft.net ever goes away or changes, this will need to be changed to
# the current distribution location.
BASE_URL='https://minecraft.net/en-us/download/server/bedrock/'

# pipe to retrieve current version from BASE_URL endpoint
# page contains currently two versions for windows server & for linux as well
URL=`curl -L ${BASE_URL} 2>/dev/null| grep bin-linux | sed -e 's/.*<a href=\"\(https:.*\/bin-linux\/.*\.zip\).*/\1/'`

# Verify if the DOWNLOAD and SERVER destinations exist. Create if it doesn't
checkAndCreateFolders () {
    echo "checking file structure"

    for check in "$MINECRAFT_DOWNLOAD" "$MINECRAFT_SERVER" ; do
        if [ ! -d ${check} ] ; then
            if [ -e ${check} ] ; then
              # Error out if it does exist but isn't a directory
              printf "\n%s is not a directory!\nPlease edit %s and change the line to point %s to the correct directory\n\n" "${check}" "$0" "${check}"
              exit 1
            fi
            mkdir -p ${check}
        fi
    done
}

downloadNewerVersionIfAvailable () {
    # Check if a copy of the latest server exists in the DOWNLOAD directory
    if [ ! -e ${MINECRAFT_DOWNLOAD}/${URL##*/} ] ; then
        # If it doesn't exist, retrieve the latest zip file and extract it to
        # the SERVER directory.
        curl ${URL} --output ${MINECRAFT_DOWNLOAD}/${URL##*/}
        # Remove older copies of the server
        find ${MINECRAFT_DOWNLOAD} -maxdepth 1 -type f -name bedrock-server\*.zip ! -newer ${MINECRAFT_DOWNLOAD}/${URL##*/} ! -name ${URL##*/} -delete
    else
        # If it does, do nothing. Either the software was downloaded manually and
        # setup should be finished manually or it has already been updated.
        printf "\nServer is up to date, nothing to do.\n\n"
        exit 0
    fi
}

updateServer () {
    echo "updating server"

    # Check for a backup copy of any existing server properties.
    # Make a backup copy if none exists.
    if [ ! -e ${MINECRAFT_SERVER}/server.properties.bak ] ; then
        cp ${MINECRAFT_SERVER}/server.properties ${MINECRAFT_SERVER}/server.properties.bak
    fi

    cd ${MINECRAFT_SERVER}
    unzip -o ${MINECRAFT_DOWNLOAD}/${URL##*/} 2>&1 > /dev/null
    # Copy the server properties backup into place
    cp ${MINECRAFT_SERVER}/server.properties.bak ${MINECRAFT_SERVER}/server.properties
}

checkAndCreateFolders
downloadNewerVersionIfAvailable
updateServer