#!/bin/bash
access_key=$1
secret_key=$2
endpoint=$3
filepath=$4
urlcrud=$5
json_id=$6

#index=$(cat $json_id | jq ".data | map(.access_key == \"$access_key\") | index(true)")

export RCLONE_CONFIG_$(echo ${access_key^^})_TYPE="s3"
export RCLONE_CONFIG_$(echo ${access_key^^})_PROVIDER="Storj"
export RCLONE_CONFIG_$(echo ${access_key^^})_ACCESS_KEY_ID="$access_key"
export RCLONE_CONFIG_$(echo ${access_key^^})_SECRET_ACCESS_KEY="$secret_key"
export RCLONE_CONFIG_$(echo ${access_key^^})_ENDPOINT="$endpoint"

export AWS_ACCESS_KEY_ID=$access_key
export AWS_SECRET_ACCESS_KEY=$secret_key
endpoint=$endpoint
mountpoint=/mount/$access_key
mkdir -p $mountpoint
goofys --endpoint $endpoint demo-bucket: $mountpoint

rclone mkdir ${access_key^^}:demo-bucket/
mv $filepath /mount/$access_key

cat $json_id | jq ".status |= \"isi\"" > $json_id.temp && mv $json_id.temp $json_id
curl --location --request PUT $urlcrud --header 'Content-Type: application/json' -d @$json_id

umount -l /mount/$access_key

rm -rf /mount/$access_key

rm -rf $json_id
