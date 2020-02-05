#!/bin/bash

set -e

echo "Concourse login ..."

ruby ./fly_login.rb \
      "${CONCOURSE_USERNAME}" \
      "${CONCOURSE_PASSWORD}" \
      "${CONCOURSE_ENV}" \
      "${CONCOURSE_URL}" \
      "${CONCOURSE_ENV}"

fly -t ${CONCOURSE_ENV} sync

echo "Creating or Updating pipeline .. ${PIPELINE_NAME}"

fly --target ${CONCOURSE_ENV} set-pipeline \
      --pipeline "${PIPELINE_NAME}" \
      --config $PIPELINE_CONFIG \
      --non-interactive

fly --target ${CONCOURSE_ENV} unpause-pipeline --pipeline "${PIPELINE_NAME}"
