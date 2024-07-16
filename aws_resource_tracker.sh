#!/bin/bash

############
#Author: Inura
#Date: 17th-Jan
#
#Version: v1
#
#This script will report the databse usage
##########################################

#All executed commands are printed to the terminal
set -x

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users



# list s3 buckets
echo  "Print list of s3 buckets"
aws s3 ls

# list ec2 instances
echo "Print list of ec2 instances"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

# list lambda
echo "Print list of lambda functions"
aws lambda list-functions

# list IAM users
echo "Print list of IAM users"
aws iam list-users
