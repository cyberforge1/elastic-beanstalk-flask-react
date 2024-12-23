#!/usr/bin/env bash

# deployment/prepare_production.sh

# Exit immediately if a command exits with a non-zero status
set -e

#####################################
# 1. Define paths and directories
#####################################
PROJECT_ROOT="$(pwd)"
OUTPUT_DIR="$PROJECT_ROOT/production_build"
BACKEND_DIR="$PROJECT_ROOT/backend"
STATIC_DIR="$BACKEND_DIR/static"

# Updated references for new config file name
NGINX_CONFIG_SRC="$PROJECT_ROOT/deployment/elastic-beanstalk-flask-react.conf"
NGINX_CONFIG_DEST="$OUTPUT_DIR/elastic-beanstalk-flask-react.conf"

# Updated ZIP file name
ZIP_FILE="$OUTPUT_DIR/elastic-beanstalk-flask-react.zip"

#####################################
# 2. Cleanup previous build artifacts
#####################################
echo "Cleaning up previous builds..."
rm -rf "$OUTPUT_DIR"
rm -rf "$STATIC_DIR"

#####################################
# 3. Build the React frontend
#####################################
echo "Building the React frontend..."
cd "$PROJECT_ROOT/frontend"
npm install --silent
npm run build --silent

#####################################
# 4. Move React build to backend/static
#####################################
echo "Moving React build to Flask static folder..."
mkdir -p "$STATIC_DIR"  # Ensure the static directory exists
cp -r dist/* "$STATIC_DIR"

#####################################
# 5. Copy Flask backend files
#####################################
echo "Copying Flask backend files..."
mkdir -p "$OUTPUT_DIR/backend"
cp -r "$BACKEND_DIR/app" "$OUTPUT_DIR/backend/"
cp "$BACKEND_DIR/run.py" "$OUTPUT_DIR/backend/"
cp "$BACKEND_DIR/requirements.txt" "$OUTPUT_DIR/backend/"
cp "$BACKEND_DIR/.env" "$OUTPUT_DIR/backend/"  # If you want .env included
cp -r "$BACKEND_DIR/migrations" "$OUTPUT_DIR/backend/"
cp "$BACKEND_DIR/wsgi.py" "$OUTPUT_DIR/backend/"  # Ensure wsgi.py is included

#####################################
# 6. Copy NGINX server configuration
#####################################
echo "Copying NGINX configuration..."
if [ -f "$NGINX_CONFIG_SRC" ]; then
    cp "$NGINX_CONFIG_SRC" "$NGINX_CONFIG_DEST"
else
    echo "Error: NGINX configuration file not found at '$NGINX_CONFIG_SRC'."
    exit 1
fi

#####################################
# 7. Set up the production backend env
#####################################
echo "Setting up the production backend environment..."

# Navigate to the production backend directory
cd "$OUTPUT_DIR/backend"

# 7.1 Create virtual environment if needed
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# 7.2 Activate virtual environment
source venv/bin/activate

# 7.3 Install dependencies
echo "Installing dependencies..."
pip install --upgrade pip --quiet
pip install -r requirements.txt --quiet

# 7.4 (Optional) Run database migrations
echo "Running database migrations..."
flask db upgrade || echo "Skipping migrations..."

# Deactivate virtual environment
deactivate
cd "$PROJECT_ROOT"

#####################################
# 8. Copy EB config folders (.ebextensions, .platform)
#####################################
if [ -d ".ebextensions" ]; then
    echo "Copying .ebextensions folder..."
    cp -r .ebextensions "$OUTPUT_DIR/"
fi

if [ -d ".platform" ]; then
    echo "Copying .platform folder..."
    cp -r .platform "$OUTPUT_DIR/"
fi

#####################################
# 9. Package into a ZIP file
#####################################
echo "Creating zip archive for production deployment..."
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"
zip -r "$ZIP_FILE" ./* > /dev/null
cd "$PROJECT_ROOT"

#####################################
# 10. Final confirmation
#####################################
echo "Production build complete!"
echo "React build location: '$STATIC_DIR'"
echo "Build directory: '$OUTPUT_DIR'"
echo "Zip archive: '$ZIP_FILE'"

# 11. (Optional) Serve the static build locally
# serve -s "$STATIC_DIR" -l 3000
