#!/bin/sh

echo "[script.sh] start."

dbt deps --profiles-dir .
if [[ $? == 1 ]]; then
 echo '[script.sh] dbt deps is faild'
 exit 1
fi

dbt debug --target prod --profiles-dir .
if [[ $? == 1 ]]; then
 echo '[script.sh] dbt debug is faild'
 exit 1
fi

dbt build --target prod --profiles-dir .
if [[ $? == 1 ]]; then
 echo '[script.sh] dbt build is faild'
 exit 1
fi

edr monitor --slack-token ${SLACK_TOKEN_ELEMENTARY} --slack-channel-name dbt-alerts
if [[ $? == 1 ]]; then
 echo '[script.sh] elementary monitor is faild'
 exit 1
fi

echo "[script.sh] script end."
