  
#!/bin/bash

set -e

echo "Concourse login ..."

fly --target "${CONCOURSE_TEAM}" login \
  --concourse-url "${CONCOURSE_URL}" \
  --team-name "${CONCOURSE_TEAM}" \
  --username "${CONCOURSE_USERNAME}" \
  --password "${CONCOURSE_PASSWORD}"


fly -t ${CONCOURSE_TEAM} sync

fly --target ${CONCOURSE_TEAM} set-pipeline \
  --pipeline "${PIPELINE_NAME}" \
  --config git-app-pipeline/"${PIPELINE_PATH}" \
  --non-interactive

fly --target ${CONCOURSE_TEAM} unpause-pipeline --pipeline "${PIPELINE_NAME}"