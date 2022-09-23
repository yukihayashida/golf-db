#!/bin/sh

echo "script start."

echo `ls`

dbt run --target ${_DBT_TARGET} --profiles-dir .

echo "script end."
