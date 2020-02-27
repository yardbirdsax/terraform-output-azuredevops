OUTPUT=`terraform output -json | jq '.ado_output'`
KEYS=`echo $OUTPUT | jq '.value | keys[]' -r`
for key in $KEYS
do
  VALUE=`echo $OUTPUT | jq ".value.${key}" -r`
  echo "##vso[task.setvariable variable=${key}]$VALUE"
done