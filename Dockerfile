FROM rclone/rclone:1

COPY docker-entrypoint.sh /usr/local/bin

RUN apk add --no-cache tzdata inotify-tools bash && \
    mkdir -p /config/triggers

ENV BACKUP_ENDPOINT=EliteCloudGD
ENV AWS_ACCESS_KEY_ID=ACCESS_KEY_ID_FOR_S3_BACKUPS
ENV AWS_SECRET_ACCESS_KEY=SECRET_KEY_FOR_S3_BACKUPS

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]


