FROM python:3.11-slim

WORKDIR /app

# Copy requirements first for better layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose Dagster gRPC port (for code location server)
EXPOSE 4000

# Run Dagster code location server (gRPC API) that connects to existing Dagster server
CMD ["dagster", "api", "grpc", "-h", "0.0.0.0", "-p", "4000", "-m", "dagster_project_sample"]

