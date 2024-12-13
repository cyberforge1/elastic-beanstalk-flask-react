#!/usr/bin/env bash
# prepare_production.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. Build the React frontend (located in frontend/)
echo "Building the React frontend..."
cd frontend
npm install
npm run build
cd ..

# 2. Define the directory to store production-ready files
OUTPUT_DIR="production_build"

# 3. Remove any previous build artifacts
echo "Cleaning up previous production build..."
rm -rf "$OUTPUT_DIR"

# 4. Create the output directory structure
echo "Creating production build directory..."
mkdir -p "$OUTPUT_DIR/frontend_build"
mkdir -p "$OUTPUT_DIR/backend"
mkdir -p "$OUTPUT_DIR/nginx"

# 5. Copy the React build output into the production_build directory
echo "Copying React build to production_build/frontend_build..."
cp -r frontend/dist/* "$OUTPUT_DIR/frontend_build"

# 6. Copy the Flask application and related files from backend/
echo "Copying Flask backend..."
cp -r backend/app "$OUTPUT_DIR/backend"
cp backend/wsgi.py "$OUTPUT_DIR/backend"
cp backend/requirements.txt "$OUTPUT_DIR/backend"
cp backend/Procfile "$OUTPUT_DIR/backend"

# 7. Copy Nginx configuration files
echo "Copying Nginx configuration..."
# Ensure nginx-flask-react.conf is in your project root directory
cp nginx-flask-react.conf "$OUTPUT_DIR/nginx"
# If you have a custom nginx.conf in your project repository, copy it as well
# Otherwise, ensure you have a reference nginx.conf available locally
# cp path/to/your/nginx.conf "$OUTPUT_DIR/nginx"

# 8. Create a zip archive inside the production_build directory
echo "Zipping the production_build directory inside production_build..."
cd "$OUTPUT_DIR"
# Exclude the zip file itself to prevent recursion
zip -r production_build.zip . -x production_build.zip

echo "Production assets have been prepared in 'production_build/' directory."
echo "The final zip file is located at 'production_build/production_build.zip'."
