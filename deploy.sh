docker build -t charanbasetti/multi-client-k8s:latest -t charanbasetti/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t charanbasetti/multi-server-k8s-pgfix:latest -t charanbasetti/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t charanbasetti/multi-worker-k8s:latest -t charanbasetti/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push charanbasetti/multi-client-k8s:latest
docker push charanbasetti/multi-server-k8s-pgfix:latest
docker push charanbasetti/multi-worker-k8s:latest

docker push charanbasetti/multi-client-k8s:$SHA
docker push charanbasetti/multi-server-k8s-pgfix:$SHA
docker push charanbasetti/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=charanbasetti/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=charanbasetti/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=charanbasetti/multi-worker-k8s:$SHA