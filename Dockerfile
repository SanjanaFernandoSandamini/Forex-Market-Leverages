# Use official Python runtime as a parent image
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements if you have one or install dependencies directly
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your app code
COPY . .

# Expose port 5000 for Flask
EXPOSE 5000

# Run the app
CMD ["python", "forex_pipeline.py"]
