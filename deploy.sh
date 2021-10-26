docker build -t nimcurry/multi-client:latest -t nimcurry/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nimcurry/multi-server:latest -t nimcurry/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nimcurry/multi-worker:latest -t nimcurry/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nimcurry/multi-client:latest
docker push nimcurry/multi-server:latest
docker push nimcurry/multi-worker:latest

docker push nimcurry/multi-client:$SHA
docker push nimcurry/multi-server:$SHA
docker push nimcurry/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image  deployments/server-deployment server=nimcurry/multi-server:$SHA
kubectl set image deployments/client-deployment client=nimcurry/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nimcurry/multi-worker:$SHA