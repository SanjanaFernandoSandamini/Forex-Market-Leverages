FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Pre-train models during build if needed
# RUN python -c "from forex_pipeline import train_models; train_models()"

EXPOSE 8000

# Use gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "forex_pipeline:app"]
