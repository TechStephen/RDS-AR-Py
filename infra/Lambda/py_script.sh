#!/bin/bash

set -e

# Step 1: Build the image
docker build -t lambda-builder .

# Step 2: Create package directory
mkdir -p lambda_package

# Step 3: Copy dependencies from container into lambda_package
docker run --rm -v "$PWD":/app -w /app lambda-builder \
  bash -c "cp -r /tmp/lambda/* lambda_package/"

# Step 4: Add your Python function code
cp functions.py lambda_package/

# Step 5: Create the deployment .zip
cd lambda_package
zip -r ../functions.zip .
cd ..

echo "✅ Lambda package created: functions.zip"
