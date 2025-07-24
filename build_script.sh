#!/bin/bash
set -e  # Exit immediately if any command fails (except where we handle it explicitly)

# Constants
REPO="767398032512.dkr.ecr.us-east-1.amazonaws.com/rds-test"
IMAGE="rds-test"
TAG="latest"

Terraform deploy
echo "🚧 Running Terraform deployment..."
terraform init
terraform validate
terraform plan

set +e  # Allow failure so we can catch the error code manually

terraform apply -auto-approve
EXIT_CODE=$?

set -e  # Re-enable immediate exit

if [ $EXIT_CODE -ne 0 ]; then
  echo "❌ Terraform apply failed. Cleaning up..."
  terraform destroy -auto-approve
  exit 1
fi

echo "✅ Terraform apply succeeded."
