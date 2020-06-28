docker build -t 0426abhi/multi-client:latest -t 0426abhi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 0426abhi/multi-server:latest -t 0426abhi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 0426abhi/multi-worker:latest -t 0426abhi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 0426abhi/multi-client:latest
docker push 0426abhi/multi-server:latest
docker push 0426abhi/multi-worker:latest

docker push 0426abhi/multi-client:$SHA
docker push 0426abhi/multi-server:$SHA
docker push 0426abhi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=0426abhi/multi-server:$SHA
kubectl set image deployments/client-deployment client=0426abhi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=0426abhi/multi-worker:$SHA