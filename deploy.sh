docker build -t onxssis/complex-client:latest -t onxssis/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t onxssis/complex-server:latest -t onxssis/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t onxssis/complex-worker:latest -t onxssis/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push onxssis/complex-client:latest
docker push onxssis/complex-server:latest
docker push onxssis/complex-worker:latest

docker push onxssis/complex-client:$SHA
docker push onxssis/complex-server:$SHA
docker push onxssis/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=onxssis/complex-server:$SHA
kubectl set image deployments/client-deployment client=onxssis/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=onxssis/complex-worker:$SHA