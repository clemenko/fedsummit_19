#!/bin/bash
#this script will create, curl and unpack a client bundle

if [ -z ${DOCS_URL+x} ]; then
  echo "Setting variables for you..."
  . ~/fedsummit_2019/scripts/var_setup.sh
fi

rm -rf /root/jenkins_home
mkdir /root/jenkins_home

jenkins_id=$(docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /root/jenkins_home/:/var/jenkins_home -e "JENKINS_BASE_URL=$DOCS_URL" e "JENKINS_PASS=admin1234"  clemenko/summit19:jenkins)
echo $jenkins_id > jenkins.id

echo "========================================================================================================="
echo ""
echo "  Jenkins URL : http://$DOCS_URL:8080"
echo ""
echo "========================================================================================================="

echo -n "  Waiting for Jenkins to start ."
for i in {1..20}; do echo -n "."; sleep 1; done
echo ""

echo "========================================================================================================="
echo ""
echo "  Jenkins Setup Password = "$(docker exec $jenkins_id cat /var/jenkins_home/secrets/initialAdminPassword)
echo ""
echo "========================================================================================================="
