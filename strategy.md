# Strategy 

- Deploy backend and frontend as a single elastic beanstalk application

- Create a script to build and deploy


``` markdown

#!/bin/bash

# Step 1: Build React Frontend
echo "Building React app..."
cd frontend
npm install
npm run build
cd ..

# Step 2: Package Flask App
echo "Packaging Flask app..."
zip -r app.zip backend frontend/build Procfile requirements.txt

# Step 3: Upload to S3
echo "Uploading to S3..."
aws s3 cp app.zip s3://$(terraform output -raw app_bucket)

# Step 4: Apply Terraform
echo "Applying Terraform..."
terraform apply -auto-approve

```

- Use an nginx server? Gunicorn?

