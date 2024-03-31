#!/bin/sh

echo "[script.sh] start."

dbt deps --profiles-dir .
if [[ $? == 1 ]]; then
 echo '[script.sh] dbt deps is faild'
fi

dbt debug --target prod --profiles-dir .
if [[ $? == 1 ]]; then
 echo '[script.sh] dbt debug is faild'
fi

dbt build --target prod --profiles-dir .
if [[ $? == 1 ]]; then
 echo '[script.sh] dbt build is faild'
fi

edr monitor --slack-token ${SLACK_TOKEN_ELEMENTARY} --slack-channel-name dbt-alerts
if [[ $? == 1 ]]; then
 echo '[script.sh] elementary monitor is faild'
fi

echo "[script.sh] script end."
