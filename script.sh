#!/bin/sh

echo "script start."

dbt deps --profiles-dir .
if [ $? == 1 ]; then
 echo 'dbt deps is faild'
 exit 1
fi

dbt debug --target prod --profiles-dir .
if [ $? == 1 ]; then
 echo 'dbt debug is faild'
 exit 1
fi

dbt build --target prod --profiles-dir .
if [ $? == 1 ]; then
 echo 'dbt build is faild'
 exit 1
fi

echo "script end."
