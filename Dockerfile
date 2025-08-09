# =====================
# Stage 1: Build Image
# =====================
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY forex_pipeline.py .

# Create models directory
RUN mkdir -p models

# Expose Flask port
EXPOSE 5000

# Environment variable
ENV FASTFOREX_API_KEY=your_api_key_here

# Healthcheck for container
HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit 1

# Run with Gunicorn
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "forex_pipeline:app"]
