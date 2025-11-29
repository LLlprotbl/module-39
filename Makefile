Makefile
PUBLIC_REGISTRY_HOST=docker.io
PUBLIC_REGISTRY_OWNER=LLlprotbl
PUBLIC_REGISTRY_APP_NAME=module-39
CI_COMMIT_REF_NAME=latest

all: deps build test

deps:
	@go mod download
	@echo "Dependencies installed successfully"

build:
	@go build ./

test:
	@go test -v ./...

lint:
	@golangci-lint run ./...

image:
	@echo "Building docker image..."
	@docker build -t ${PUBLIC_REGISTRY_HOST}/${PUBLIC_REGISTRY_OWNER}/${PUBLIC_REGISTRY_APP_NAME}:${CI_COMMIT_REF_NAME} ./
	@echo "Pushing image to registry..."
	@docker push ${PUBLIC_REGISTRY_HOST}/${PUBLIC_REGISTRY_OWNER}/${PUBLIC_REGISTRY_APP_NAME}:${CI_COMMIT_REF_NAME}
	@make image-info

image-info:
	@echo "New ${PUBLIC_REGISTRY_HOST}/${PUBLIC_REGISTRY_OWNER}/${PUBLIC_REGISTRY_APP_NAME} image ready! Version ${CI_COMMIT_REF_NAME}!"

.PHONY: all deps build test lint image image-info