#!/bin/bash

# Deploy VProfile application to Kubernetes with auto-scaling

echo "Deploying VProfile application to Kubernetes..."

# Create namespace
kubectl apply -f namespace.yaml

# Deploy database and services
kubectl apply -f mysql-deployment.yaml
kubectl apply -f memcached-deployment.yaml
kubectl apply -f rabbitmq-deployment.yaml

# Wait for database to be ready
echo "Waiting for database to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/vprodb -n vprofile

# Deploy application with auto-scaling
kubectl apply -f vproapp-deployment.yaml

# Deploy web server
kubectl apply -f nginx-deployment.yaml

echo "Deployment complete!"
echo "Check status with: kubectl get all -n vprofile"
echo "Check HPA with: kubectl get hpa -n vprofile"
echo ""
echo "To test auto-scaling:"
echo "1. Run load test: kubectl apply -f load-test.yaml"
echo "2. Run stress test: kubectl apply -f stress-test.yaml"
echo "3. Monitor scaling: kubectl get hpa -n vprofile -w"
echo "4. Watch pods: kubectl get pods -n vprofile -w"