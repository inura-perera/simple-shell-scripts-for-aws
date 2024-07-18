#!/bin/bash

# Variables - customize these according to your requirements

AMI_ID="ami-0c55b159cbfafe1f0"   
INSTANCE_TYPE="t2.micro"         
KEY_NAME="my-key-pair"           
SECURITY_GROUP="my-security-group"  
SUBNET_ID="subnet-12345678"      
TAG_NAME="MyEC2Instance"         
IAM_ROLE="my-iam-role"           

# Create EC2 instance

INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURITY_GROUP \
    --subnet-id $SUBNET_ID \
    --iam-instance-profile Name=$IAM_ROLE \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$TAG_NAME}]" \
    --query 'Instances[0].InstanceId' \
    --output text)

# Check if instance was created successfully

if [ -z "$INSTANCE_ID" ]; then
    echo "Failed to create EC2 instance."
    exit 1
else
    echo "EC2 instance created successfully. Instance ID: $INSTANCE_ID"
fi

# Wait for the instance to be in a running state

echo "Waiting for instance to enter 'running' state..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Fetch the public IP address of the instance

PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

if [ -z "$PUBLIC_IP" ]; then
    echo "Failed to retrieve public IP address."
else
    echo "EC2 instance is running. Public IP address: $PUBLIC_IP"
fi
