#!/bin/bash
#this script will pull, tag and push images for PWD.

if [ -z ${DTR_URL+x} ]; then
  echo Setting variables for you...
  . ~/fedsummit_2019/scripts/var_setup.sh
fi

if [ -z ${DTR_TOKEN+x} ]; then
  echo " Please create a DTR_TOKEN variable before preceeding..."
  exit
fi

#login
docker login -u jenkins -p $DTR_TOKEN $DTR_URL

#pull
docker pull clemenko/summit19:flask
docker pull alpine
docker pull nginx:1.11.9-alpine

#tag
docker tag clemenko/summit19:flask $DTR_URL/ci/summit19_build:flask
docker tag alpine $DTR_URL/ci/summit19_build:alpine
docker tag nginx:1.11.9-alpine $DTR_URL/ci/summit19_build:nginx

#push
docker push $DTR_URL/ci/summit19_build:flask
docker push $DTR_URL/ci/summit19_build:alpine
docker push $DTR_URL/ci/summit19_build:nginx

echo ""
