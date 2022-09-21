#!/bin/sh

echo "script start."

echo `pwd`

dbt run --profiles-dir .

echo "script end."
