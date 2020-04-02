#!/bin/bash

set -e

credhub login --skip-tls-validation

CONCOURSE_PASSWORD="$(credhub get -q -n /concourse/${CONCOURSE_TEAM}/ci-user-password)"

echo "Concourse login ..."

fly --target "${CONCOURSE_TEAM}" login \
  --concourse-url "${CONCOURSE_URL}" \
  --team-name "${CONCOURSE_TEAM}" \
  --username "${CONCOURSE_USERNAME}" \
  --password "${CONCOURSE_PASSWORD}"


fly -t ${CONCOURSE_TEAM} sync

if [ -z $VARIABLE_FILE ]; then
  fly --target "${CONCOURSE_TEAM}" set-pipeline \
    --pipeline "${PIPELINE_NAME}" \
    --config "${PIPELINE_CONFIG}" \
    --non-interactive

  fly --target "${CONCOURSE_TEAM}" unpause-pipeline --pipeline "${PIPELINE_NAME}"
else
  fly --target "${CONCOURSE_TEAM}" set-pipeline \
    --pipeline "${PIPELINE_NAME}" \
    --config "${PIPELINE_CONFIG}" \
    --load-vars-from "${VARIABLE_FILE}"
    --non-interactive

  fly --target "${CONCOURSE_TEAM}" unpause-pipeline --pipeline "${PIPELINE_NAME}"
fi