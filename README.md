# k8s-playground

**k8s-playground** is a test project to validate the local Kubernetes environment and ensure that the necessary stack for work is properly configured. This project includes a backend and frontend Docker image, a local registry, and Kubernetes deployment configurations.

## Prerequisites

- Docker
- Kubernetes (using Rancher Desktop or Minikube)
- `kubectl` installed and configured
- `docker-compose` installed

## Project Structure

```bash
.
├── docker
│   ├── backend
│   │   ├── Dockerfile
│   │   └── server.py
│   ├── frontend
│   │   ├── Dockerfile
│   │   └── default.conf
├── k8s
│   ├── backend
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   ├── frontend
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   ├── registry
│   │   ├── deployment.yaml
│   │   └── service.yaml
├── compose
│   ├── docker-compose.yaml
├── Makefile
└── README.md
```

## How to Run

This project provides several commands for building Docker images, deploying them to Kubernetes, and setting up a local Docker registry. Below are the available commands and steps to run them.

### Step 1: Build Docker Images with Docker Compose

To build the `frontend` and `backend` Docker images using Docker Compose, run the following command:

```bash
make compose
```

### Step 2: Deploy a Local Registry on Kubernetes

To set up a local Docker registry on your Kubernetes cluster, run the following command:

```bash
make registry
```

This command applies the `deployment.yaml` and `service.yaml` for the registry located in the `k8s/registry` directory. The registry will be exposed on port `32000`.

### Step 3: Build Docker Images Manually

To build the Docker images for both the `frontend` and `backend` manually, use:

```bash
make build-images
```

### Step 4: Tag Docker Images for Local Registry

To tag the Docker images to be pushed to the local registry (`localhost:32000`), use:

```bash
make tag-images
```

### Step 5: Push Docker Images to the Local Registry

Once the images are tagged, push them to the local registry with:

```bash
make push-images
```

This will push both `frontend` and `backend` images to the local registry running on `localhost:32000`.

### Step 6: Deploy the Backend and Frontend to Kubernetes

After the images are pushed to the local registry, you can deploy the `frontend` and `backend` applications to Kubernetes by applying the appropriate deployment and service files.

For the backend:

```bash
kubectl apply -f k8s/backend/deployment.yaml -f k8s/backend/service.yaml
```

For the frontend:

```bash
kubectl apply -f k8s/frontend/deployment.yaml -f k8s/frontend/service.yaml
```

### Accessing the Applications

- The **frontend** service will be exposed via a `NodePort` or `LoadBalancer` (depending on your configuration).
- The **backend** service is internal and accessible only within the cluster by other services (such as the frontend).

## Cleaning Up

To clean up and remove the deployed services and registry, you can delete the deployments and services as follows:

```bash
make clean
```