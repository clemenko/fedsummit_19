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
docker pull clemenko/summit19:v1
docker pull alpine
docker pull alpine:3.3

#tag
docker tag clemenko/summit19:v1 $DTR_URL/ci/summit19_build:v1
docker tag alpine $DTR_URL/ci/summit19_build:alpine
docker tag alpine:3.3 $DTR_URL/ci/summit19_build:alpine3.3

#push
docker push $DTR_URL/ci/summit19_build:v1
docker push $DTR_URL/ci/summit19_build:alpine
docker push $DTR_URL/ci/summit19_build:alpine3.3

echo ""
