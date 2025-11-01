FROM python:3.11-slim

WORKDIR /app

# Copy requirements first for better layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Set PYTHONPATH to include /app so Python can find the module
ENV PYTHONPATH=/app

# Expose Dagster gRPC port (for code location server)
EXPOSE 4000

# Verify module can be imported (for debugging)
RUN python -c "import dagster_project_sample; print('Module imported successfully')"

# Run Dagster code location server (gRPC API) that connects to existing Dagster server
CMD ["dagster", "api", "grpc", "--host", "0.0.0.0", "--port", "4000", "--module", "dagster_project_sample"]

