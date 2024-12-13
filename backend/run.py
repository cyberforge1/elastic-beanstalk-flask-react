# backend/run.py

from dotenv import load_dotenv
import os

# Load environment variables from the .env file BEFORE importing create_app
load_dotenv()

# Debugging: Print SQLALCHEMY_DATABASE_URI to ensure it's loaded
print("DEBUG (run.py): SQLALCHEMY_DATABASE_URI loaded:", os.getenv("SQLALCHEMY_DATABASE_URI"))

from app import create_app

app = create_app()

if __name__ == '__main__':
    # Running the built-in Flask server for local development on port 5001.
    # For production, run: gunicorn --bind 0.0.0.0:5001 wsgi:application
    app.run(host="0.0.0.0", port=5001)
