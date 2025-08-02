# VProfile Kubernetes Deployment with Auto-Scaling

## Prerequisites
- Kubernetes cluster (minikube, EKS, GKE, etc.)
- kubectl configured
- Metrics server installed for HPA

## Deploy Application

```bash
# Make script executable
chmod +x deploy.sh

# Deploy all components
./deploy.sh
```

## Manual Deployment

```bash
# Create namespace
kubectl apply -f namespace.yaml

# Deploy services
kubectl apply -f mysql-deployment.yaml
kubectl apply -f memcached-deployment.yaml
kubectl apply -f rabbitmq-deployment.yaml
kubectl apply -f vproapp-deployment.yaml
kubectl apply -f nginx-deployment.yaml
```

## Auto-Scaling Configuration

The application includes Horizontal Pod Autoscaler (HPA) that:
- Scales between 2-20 replicas
- Scales up when CPU > 60% or Memory > 70%
- Scales based on HTTP requests per second (>100 req/s)
- Fast scale-up (100% in 60s), slow scale-down (10% in 60s)
- Monitors vproapp deployment

## Load-Based Auto-Scaling Test

```bash
# Test auto-scaling with load
./test-scaling.sh

# Or manually:
kubectl apply -f stress-test.yaml
kubectl get hpa -n vprofile -w
```

## Check Status

```bash
# Check all resources
kubectl get all -n vprofile

# Check HPA status
kubectl get hpa -n vprofile

# Check pod scaling
kubectl top pods -n vprofile
```

## Access Application

```bash
# Get LoadBalancer IP
kubectl get svc vproweb-service -n vprofile

# Port forward for local access
kubectl port-forward svc/vproweb-service 8080:80 -n vprofile
```

## Clean Up

```bash
kubectl delete namespace vprofile
```