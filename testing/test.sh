#!/bin/bash

file_path="/home/ec2-user/node-api/app.js"

if [ -f "$file_path" ]; then
    echo "Application file exists. Proceed with deployment."
else
    echo "Application File does not exist. Testing failed."
    exit 1
fi
