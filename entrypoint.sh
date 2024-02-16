#!/usr/bin/env sh

# stop on error
set -e
IMAGE_NAME=$1
IMAGE_TAG=$2
KEEL_WEBHOOK_URL=$3
KEEL_USERNAME=$4
KEEL_PASSWORD=$5

# make sure the following env variables are set
[ -z "$IMAGE_TAG" ] && { echo "IMAGE_TAG not set"; exit 1; }
[ -z "$KEEL_WEBHOOK_URL" ] && { echo "KEEL_WEBHOOK_URL not set"; exit 1; }
[ -z "$KEEL_USERNAME" ] && { echo "KEEL_USERNAME not set"; exit 1; }
[ -z "$KEEL_PASSWORD" ] && { echo "KEEL_PASSWORD not set"; exit 1; }

curl --header "Content-Type: application/json" \
    --request POST \
    --data "{\"name\": \"$IMAGE_NAME\", \"tag\": \"$IMAGE_TAG\"}" \
    --user "$KEEL_USERNAME:$KEEL_PASSWORD" \
    "$KEEL_WEBHOOK_URL/v1/webhooks/native"
