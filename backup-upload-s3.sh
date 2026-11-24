#!/bin/bash
# /usr/local/bin/backup-upload-s3.sh
# Uploads Proxmox vzdump archives to S3 and sends SNS notification
# Called as a vzdump hook via /etc/vzdump.conf
# Requires IAM creds in /root/.aws/credentials

if [ "$1" == "job-end" ]; then
    /root/.local/bin/aws s3 sync /var/lib/vz/dump s3://homelab-backups-700922282181-us-east-1-an --exclude "*.tmp/*" --exclude "*.dat"

    /root/.local/bin/aws sns publish --topic-arn arn:aws:sns:us-east-1:700922282181:BackupEmails --message "pve01 backup service has executed successfully!"
fi

exit 0