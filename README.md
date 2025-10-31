# Dagster Hello World Project

A simple Dagster project that prints "Hello World!" running in a Docker container. This project runs as a code location server that connects to your existing Dagster server.

## Project Structure

```
dagster_project_sample/
├── assets/
│   ├── __init__.py
│   └── hello_world.py    # Asset that prints hello world
├── __init__.py           # Definitions
├── requirements.txt      # Python dependencies
├── Dockerfile            # Container definition
├── docker-compose.yml    # Docker Compose configuration
└── README.md            # This file
```

## Running with Docker Compose

### Network Setup

This project is configured to run on the same network as your Dagster service. The default network name is `dagster-network`.

**If the network doesn't exist yet, create it:**
```bash
docker network create dagster-network
```

**If your Dagster service uses a different network name:**
1. Edit `docker-compose.yml`
2. Change the network name on line 22 from `dagster-network` to your network name

### Starting the Service

This container runs a gRPC code location server on port 4000 that your existing Dagster server can connect to.

1. Build and start the container:
```bash
docker-compose up --build
```

2. Connect to your existing Dagster server:
   - In your existing Dagster server configuration, add this code location:
     - **Host**: `dagster-hello-world` (container name) or the container's IP on the network
     - **Port**: `4000`
     - **Module**: `dagster_project_sample`

3. Access your existing Dagster UI and you should see the `hello_world` asset available

4. Run the hello_world asset:
   - In the Dagster UI, navigate to Assets
   - Find the `hello_world` asset
   - Click "Materialize" to run it
   - The asset will print "Hello World!" in the logs

5. Stop the container:
```bash
docker-compose down
```

**Note**: Make sure your existing Dagster server is configured to connect to code locations via gRPC and can reach this container on the shared network.

## Running Locally (without Docker)

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run Dagster:
```bash
dagster dev -m dagster_project_sample
```

3. Access the UI at `http://localhost:3000`

