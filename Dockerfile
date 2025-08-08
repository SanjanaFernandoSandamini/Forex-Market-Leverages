# =====================
# Stage 1: Build Image
# =====================
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies needed for building and runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency list
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY forex_pipeline.py .

# Create models directory for saved models
RUN mkdir -p models

# Expose API port
EXPOSE 5000

# Set environment variables (make sure to override at runtime)
ENV FASTFOREX_API_KEY=your_api_key_here

# Run the app with Gunicorn (4 workers, bind to all interfaces port 8000)
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "forex_pipeline:app"]


