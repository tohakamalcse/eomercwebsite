# Use official Python image
FROM python:3.10-slim

# Set workdir to the project root
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy entire project
COPY . .

# Set working directory to where manage.py is
WORKDIR /app/ecom

# Expose Django default port
EXPOSE 8000

# Start server
CMD ["gunicorn", "ecom.wsgi:application", "--bind", "0.0.0.0:8000"]
