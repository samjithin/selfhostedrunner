#!/bin/bash
ACTIONS_RUNNER_INPUT_NAME=$HOSTNAME
#get regsistration token for this runnner
ACTIONS_RUNNER_INPUT_TOKEN="$(curl -sS --request POST --url "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/registration-token" --header "authorization: Bearer ${GITHUB_TOKEN}"  --header 'content-type: application/json' | jq -r .token)"
#configure runner
/runner/config.sh --unattended --replace --work "/tmp" --url "https://github.com/samjithin/terraform" --token "$ACTIONS_RUNNER_INPUT_TOKEN"
#start runner
#https://github.com/actions/runner/issues/246#issuecomment-615293718
/runner/bin/runsvc.sh
