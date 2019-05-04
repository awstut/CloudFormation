#AWS Cloudformation Demo
This is an example of an automatically provisioned Fullstack web application using AWS Cloudformation 
##Cloudformation Setup
###Prerequisites
####AWS
- You will need an [AWS account](https://aws.amazon.com/)
- You will need to create an [EC2 Keypair](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/getstarted-keypair.html)

####Shell Script (AWS_Setup.sh)
It's possible to use the Cloudformation templates manually [using the AWS Console](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/GettingStarted.html), however it's easier and faster to setup the Cloudformation stacks programatically with the aws. 
This project was developed on Ubuntu 18.04
To run the AWS_Setup script, you will need to install and configure: 
- [aws cli](https://medium.com/pablo_ezequiel/install-aws-cli-on-ubuntu-fcaea15e832f) `sudo pip install awscli`
- [jq](https://stedolan.github.io/jq/) `sudo apt-get install jq`


###Setup
To setup the application's inrastructure, run: 
`sh AWS_Setup.sh <APP_NAME> <EC2_KEYPAIR>`
Where APP_NAME is the name you wish to call the application and EC2_KEYPAIR is the ssh key for the EC2 instances.