#!/bin/bash

echo "Testing VProfile Auto-Scaling with Load..."

# Deploy stress test
echo "Deploying stress test..."
kubectl apply -f stress-test.yaml

# Wait for stress test to start
echo "Waiting for stress test to start..."
kubectl wait --for=condition=available --timeout=60s deployment/stress-test -n vprofile

echo "Stress test started. Monitoring auto-scaling..."
echo "Press Ctrl+C to stop monitoring"

# Monitor HPA in real-time
kubectl get hpa vproapp-hpa -n vprofile -w &
HPA_PID=$!

# Monitor pods
kubectl get pods -n vprofile -w &
PODS_PID=$!

# Wait for user input
read -p "Press Enter to stop stress test and clean up..."

# Clean up
echo "Stopping stress test..."
kubectl delete deployment stress-test -n vprofile
kubectl delete service stress-test-service -n vprofile

# Kill monitoring processes
kill $HPA_PID $PODS_PID 2>/dev/null

echo "Load test completed!"