#!/bin/bash
cat logo.txt
cd /scripts
if $AUTO_UPDATE ; then
    ./update.sh
else
    echo "Auto-updates disabled. Skipping."
fi && \
if $BACKUPS ; then
    ./backup.sh
else
    echo "Backups disabled. Skipping."
fi && \
# Run server
./server.sh