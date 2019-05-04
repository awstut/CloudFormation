#!/bin/bash
# Usage: AWS_Setup.sh <APP_NAME> <EC2_KEY_NAME>

SOURCE=$0
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"


USAGE_MESSAGE="Usage: AWS_Setup.sh <APP_NAME> <EC2_KEY_NAME>"
APP_NAME=$1
EC2_KEY_NAME=$2

echo ""
echo "SRC: ${SOURCE}"
echo "DIR: ${DIR}"

#Check Parameters
if [ -z "$1" ]
  then
    echo "No APP_NAME argument supplied"
    echo $USAGE_MESSAGE
    exit 1
fi

if [ -z "$2" ]
  then
    echo "No EC2_KEY_NAME argument supplied"
    echo $USAGE_MESSAGE
    exit 1
fi

#Echo Parameters given to script
echo "Parameters"
echo "SRC: ${SOURCE}"
echo "DIR: ${DIR}"
echo "APP_NAME: ${APP_NAME}"
echo "EC2_KEY_NAME: ${EC2_KEY_NAME}"
echo ""

#Create VPC with subnets, NACLs, route tables and internet gateway
echo "Creating VPC Layer..."
VPC_STACK_ID=$( \
  aws cloudformation create-stack \
  --stack-name "${APP_NAME}-VPC" \
  --template-body file://${DIR}/1_VPC_Template.yml \
  --capabilities CAPABILITY_IAM \
  | jq -r .StackId \
)

echo "Waiting on ${VPC_STACK_ID} create completion..."
aws cloudformation wait stack-create-complete --stack-name ${VPC_STACK_ID}
VPC_STACK_NAME=$(aws cloudformation describe-stacks --stack-name MyApp-VPC | jq .Stacks[0].StackName)
echo "Created ${VPC_STACK_NAME}"

