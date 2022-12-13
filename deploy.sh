docker build -t cope2012/multi-client:latest -t cope2012/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cope2012/multi-worker:latest -t cope2012/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t cope2012/multi-server:latest -t cope2012/multi-server:$SHA -f ./server/Dockerfile ./server

docker push cope2012/multi-client:latest
docker push cope2012/multi-worker:latest
docker push cope2012/multi-server:latest

docker push cope2012/multi-client:$SHA
docker push cope2012/multi-worker:$SHA
docker push cope2012/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=cope2012/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cope2012/multi-worker:$SHA
kubectl set image deployments/client-deployment client=cope2012/multi-client:$SHA