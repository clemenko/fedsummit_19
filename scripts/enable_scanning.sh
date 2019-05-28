#!/bin/bash
#this script will enable the security scanning on DTR

if [ -z ${UCP_URL+x} ]; then
  echo Setting variables for you...
  . ~/fedsummit_2019/scripts/var_setup.sh
fi

curl -kX POST --user $DTR_USERNAME:$DTR_ADMIN_PASSWORD "https://$DTR_URL/api/v0/meta/settings" -H "Content-Type: application/json" -H "Accept: application/json"  -d '{ "reportAnalytics": false, "anonymizeAnalytics": false, "disableBackupWarning": true, "scanningEnabled": true, "scanningSyncOnline": true, "scanningEnableAutoRecheck": true }' > /dev/null 2>&1