#!/bin/bash

# SNAP_NAME=$(curl -s https://ss.pryzm.nodestake.org/ | egrep -o ">20.*\.tar.lz4" | tr -d ">")
# curl -o - -L https://ss.pryzm.nodestake.org/${SNAP_NAME}  | lz4 -c -d - | tar -x -C $HOME/.pryzm

# List of URLs to check 
urls=(
    "https://files.andromedanode.co/$PROJECT/snap_$PROJECT.tar.lz4"
    "https://snapshots.polkachu.com/snapshots/orai/orai_29408148.tar.lz4"
    "https://chains.oldcat.io/mainnets/orai/orai_29985734.tar.lz4"
    "https://snapshots.nysa.network/Oraichain/Oraichain_29940329.tar.lz4"
    "https://files.node4all.nl/$PROJECT/snap_$PROJECT.tar.lz4"
    # Add more URLs here if needed
)

# Iterate over each URL
for url in "${urls[@]}"; do
    if curl -s --head "$url" | head -n 1 | grep "200" > /dev/null; then
        # If the URL returns status 200, download and extract the archive
        if curl "$url" | lz4 -dc - | tar -xf - -C "$DIRECTORY"; then
            echo "Download and extraction successful from: $url"
            # Exit loop since download was successful
            break
        else
            echo "Failed to extract archive from: $url"
        fi
    else
        echo "URL $url is not available."
    fi
done
