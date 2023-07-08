#!/bin/sh

# entrypoint.sh

# Set the necessary environment variables
export FLASK_APP=my_distinct_package_name.app:app  # Replace "your_application" with the name of your Flask application module
export FLASK_ENV=production  # Set the desired Flask environment (e.g., "development", "production")

# Start Gunicorn
exec gunicorn --bind 0.0.0.0:$PORT --workers 4 my_distinct_package_name.app:app  # Replace "your_application" with the name of your Flask application module
