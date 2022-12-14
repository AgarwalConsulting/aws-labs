#!/usr/bin/env bash

terraform output --json | jq .participant_creds.value | tee /tmp/participant_creds.json

./scripts/eks/generate-commands.rb > /tmp/eks-access-commands.sh

chmod 744 /tmp/eks-access-commands.sh

/tmp/eks-access-commands.sh

dasel -r json -w csv < /tmp/participant_creds.json > "$HOME/odrive/Google Drive/Temp/AWSCreds/participant_creds.csv"
