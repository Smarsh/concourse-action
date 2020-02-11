#!/bin/bash

set -e

echo "Concourse login ..."

ruby "/fly_login.rb" \
      "${CONCOURSE_USERNAME}" \
      "${CONCOURSE_PASSWORD}" \
      "${CONCOURSE_TEAM}" \
      "${CONCOURSE_URL}" \
      "${CONCOURSE_TEAM}"

fly -t ${CONCOURSE_TEAM} sync

echo "Creating or Updating pipeline .. ${PIPELINE_NAME}"

fly --target ${CONCOURSE_TEAM} set-pipeline \
      --pipeline "${PIPELINE_NAME}" \
      --config $PIPELINE_CONFIG \
      --non-interactive

fly --target ${CONCOURSE_TEAM} unpause-pipeline --pipeline "${PIPELINE_NAME}"
