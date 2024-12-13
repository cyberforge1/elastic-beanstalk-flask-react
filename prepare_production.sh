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
mkdir -p "$OUTPUT_DIR/backend/app/static"  # Ensure static directory exists
mkdir -p "$OUTPUT_DIR/backend"
# mkdir -p "$OUTPUT_DIR/nginx"  # This can be omitted since Nginx is not used

# 5. Copy the React build output into the Flask app's static directory
echo "Copying React build to production_build/backend/app/static..."
cp -r frontend/dist/* "$OUTPUT_DIR/backend/app/static"

# 6. **New Step**: Copy the React build output directly to the local `backend/static` directory
echo "Copying React build to local backend/static directory..."
# Ensure the local backend/static directory exists
mkdir -p backend/static
cp -r frontend/dist/* backend/static/

# 7. Copy the Flask application and related files from backend/
echo "Copying Flask backend..."
cp -r backend/app "$OUTPUT_DIR/backend"
cp backend/wsgi.py "$OUTPUT_DIR/backend"
cp backend/requirements.txt "$OUTPUT_DIR/backend"
cp backend/Procfile "$OUTPUT_DIR/backend"

# 8. (Omitted) Copy Nginx configuration files since Nginx is not used

# 9. Create a zip archive inside the production_build directory
echo "Zipping the production_build directory inside production_build..."
cd "$OUTPUT_DIR"
# Exclude the zip file itself to prevent recursion
zip -r production_build.zip . -x production_build.zip

echo "Production assets have been prepared in the 'production_build/' directory."
echo "The final zip file is located at 'production_build/production_build.zip'."
