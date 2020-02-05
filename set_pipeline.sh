#!/bin/bash

set -e

echo "Concourse login ..."

# This is necessary because Smarsh uses Cloud Foundry's UAA for Concourse user authentication, and it's not possible to do a regulary `fly login`
ruby ./ci/tasks/set-pipelines/fly_login.rb \
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
