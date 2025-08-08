# =====================
# Stage 1: Build Image
# =====================
FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY forex_pipeline.py .

RUN mkdir -p models

EXPOSE 5000

ENV FASTFOREX_API_KEY=your_api_key_here

# Optional health check
HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit 1

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "forex_pipeline:app"]



