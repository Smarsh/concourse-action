  
#!/bin/bash

set -e

echo "Concourse login ..."

# This is necessary because Smarsh uses Cloud Foundry's UAA for Concourse user authentication, and it's not possible to do a regulary `fly login`
fly --target "${CONCOURSE_ENV}" login \
  --concourse-url "${CONCOURSE_URL}" \
  --team-name "${CONCOURSE_ENV}" \
  --username "${CONCOURSE_USERNAME}" \
  --password "${CONCOURSE_PASSWORD}"


fly -t ${CONCOURSE_ENV} sync

fly --target ${CONCOURSE_ENV} set-pipeline \
  --pipeline "${PIPELINE_NAME}" \
  --config git-app-pipeline/"${PIPELINE_PATH}" \
  --non-interactive

fly --target ${CONCOURSE_ENV} unpause-pipeline --pipeline "${PIPELINE_NAME}"