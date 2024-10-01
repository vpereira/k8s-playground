.PHONY: compose registry build-images tag-images push-images

compose:
	@docker-compose -f compose/docker-compose.yaml build

build-images:
	@docker build -t backend-image ./docker/backend
	@docker build -t frontend-image ./docker/frontend

tag-images: build-images
	@docker tag backend-image localhost:32000/backend-image
	@docker tag frontend-image localhost:32000/frontend-image

push-images: tag-images
	@docker push localhost:32000/frontend-image
	@docker push localhost:32000/backend-image

deploy-frontend:
	@kubectl apply -f k8s/frontend/deployment.yaml -f k8s/frontend/service.yaml

deploy-backend:
	@kubectl apply -f k8s/backend/deployment.yaml -f k8s/backend/service.yaml

deploy-registry:
	@kubectl apply -f k8s/registry/deployment.yaml -f k8s/registry/service.yaml

clean:
	@kubectl delete -f k8s/frontend/deployment.yaml -f k8s/frontend/service.yaml
	@kubectl delete -f k8s/backend/deployment.yaml -f k8s/backend/service.yaml
	@kubectl delete -f k8s/registry/deployment.yaml -f k8s/registry/service.yaml

