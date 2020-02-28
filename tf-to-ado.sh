#!/usr/bin/env bash

set -e

echo $1

OUTPUT=`cat - | jq '.ado_output'`
KEYS=`echo $OUTPUT | jq '.value | keys[]' -r`
for key in $KEYS
do
  VALUE=`echo $OUTPUT | jq ".value.${key}" -r`
  echo "##vso[task.setvariable variable=${key}]$VALUE"
done