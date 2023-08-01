#!/bin/sh

#--- Create an S3 bucket ---#
# Utility script to create an S3 bucket to be used to store CDP-Core packages

usage() {
    echo "Usage: $0 <bucket-name> <region>"
    exit 1
}

remove() {
    echo "Removing bucket $name"
    aws s3 rm s3://$name --recursive
    aws s3api delete-bucket --bucket $name
    if [ $? -ne 0 ]; then
        echo "Failed to remove bucket $name"
        exit 1
    fi
}

if [ $# -ne 2 ]; then
    usage
fi

name=$1
region=$2

aws s3api create-bucket --bucket $name --region $region --create-bucket-configuration LocationConstraint=$region
if [ $? -ne 0 ]; then
    echo "Failed to create bucket $name"
    exit 1
fi

aws s3api delete-public-access-block --bucket $name --region $region
if [ $? -ne 0 ]; then
    echo "Failed to delete bucket policy for $name"
    remove
    exit 1
fi

policy_json='{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::'"$name"'/*"
    }
  ]
}'

aws s3api put-bucket-policy --bucket "$name" --policy "$policy_json"
if [ $? -ne 0 ]; then
    echo "Failed to set bucket policy for $name"
    remove
    exit 1
fi
echo "S3 bucket '$name' created in region '$region' with public-read access policy."



