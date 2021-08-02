SHA=${SHA:-`git rev-parse HEAD`}
docker build -t hsakbo/multi-client:$SHA -t hsakbo/multi-client:latest -f ./client/Dockerfile ./client && \
docker build -t hsakbo/multi-server:$SHA -t hsakbo/multi-server:latest -f ./server/Dockerfile ./server && \
docker build -t hsakbo/multi-worker:$SHA -t hsakbo/multi-worker:latest -f ./worker/Dockerfile ./worker && \
docker push hsakbo/multi-client:$SHA && \
docker push hsakbo/multi-server:$SHA && \
docker push hsakbo/multi-worker:$SHA && \
docker push hsakbo/multi-client:latest && \
docker push hsakbo/multi-server:latest && \
docker push hsakbo/multi-worker:latest && \
kubectl apply -f k8s && \
kubectl set image deployments/server-deployment server=hsakbo/multi-server:$SHA && \
kubectl set image deployments/client-deployment client=hsakbo/multi-client:$SHA && \
kubectl set image deployments/worker-deployment worker=hsakbo/multi-worker:$SHA
