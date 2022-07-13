#!/usr/bin/env bash

# Backup runtime loop script

BUCKET=${BUCKET:-'emcn-backups'}
while true; do
    /usr/bin/inotifywait -e create -e modify -e move /config/triggers
    if [ -f /config/triggers/do_backup.trigger ]; then
        FILE_NAME="elite-pi-backup.$(date +%Y-%m-%d-%H.%M.%S).tgz"
        echo $FILE_NAME > /config/triggers/do_backup.trigger.running
        tar -zvcf /backups/$FILE_NAME /data
        echo "Backup create $FILENAME"
        rm -f /config/triggers/do_backup.trigger.running
        rm -f /config/triggers/do_backup.trigger
    fi

    if [ -f /config/triggers/do_upload.trigger ]; then
        echo "Sync Started $(date)" > /config/triggers/do_upload.trigger.running
        echo "Uploading to cloud"
        rclone --verbose sync /backups $BACKUP_ENDPOINT:/$BUCKET/$JWT_KEY
        rm -f /config/triggers/do_upload.trigger.running
        rm -f /config/triggers/do_upload.trigger
    fi
done
