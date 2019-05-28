#!/bin/bash
# requires environment variables: DTR_HOST, DTR_USERNAME and DTR_TOKEN

if [ -z ${DTR_TOKEN+x} ]; then
  echo " Please create a DTR_TOKEN variable before preceeding..."
  exit
fi

echo "creating the repos"
curl -X POST -k -L -u $DTR_USERNAME:$DTR_TOKEN \
  https://$DTR_URL/api/v0/repositories/ci \
  -H 'Content-Type: application/json' \
  -d '{
  "enableManifestLists": false,
  "immutableTags": false,
  "longDescription": "",
  "name": "summit19",
  "scanOnPush": true,
  "shortDescription": "Docker Summit 2019 Example - public",
  "visibility": "public"
}'

curl -X POST -k -L \
  -u $DTR_USERNAME:$DTR_TOKEN \
  https://$DTR_URL/api/v0/repositories/ci \
  -H 'Content-Type: application/json' \
  -d '{
  "enableManifestLists": false,
  "immutableTags": true,
  "longDescription": "",
  "name": "summit19_build",
  "scanOnPush": true,
  "shortDescription": "Docker Summit Example - private",
  "visibility": "private"
}'

echo ""

echo "adding promotion policy"
curl -skX POST -u $DTR_USERNAME:$DTR_TOKEN "https://$DTR_URL/api/v0/repositories/ci/summit19_build/promotionPolicies?initialEvaluation=true" -H "accept: application/json" -H "content-type: application/json" -d '{ "enabled": true, "rules": [ { "field": "vulnerability_critical", "operator": "lte", "values": [ "5" ] } ], "tagTemplate": "%n", "targetRepository": "ci/summit19"}'

echo ""

