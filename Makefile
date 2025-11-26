.PHONY: tests
tests :
	@echo "Running tests..."
	export PYTHONPATH=.  ;\
	echo $(PYTHONPATH) ;\
	pytest -v
	
build : 
	docker build -t minesweeper . 

run : build 
	docker run -p 8080:8080 minesweeper

build_gcp :
	docker build -t ${LOCATION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE} .

push_gcp: build_gcp
	docker push ${LOCATION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE} 

deploy : push_gcp
	gcloud run deploy little-pengouins \
		--image=${LOCATION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE} \
		--platform=managed \
		--region=${LOCATION} \
		--allow-unauthenticated \
		--port=8080