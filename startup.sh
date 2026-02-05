#!/bin/bash
# Azure App Service startup script

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Start the Flask application
gunicorn --bind=0.0.0.0:8000 --timeout 600 app:app
