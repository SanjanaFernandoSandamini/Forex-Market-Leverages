FROM python:3.10-slim

WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Explicitly set PYTHONPATH
ENV PYTHONPATH=/app

EXPOSE 8000

# Make sure forex_pipeline.py contains a variable 'app = Flask(__name__)'
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "forex_pipeline:app"]
