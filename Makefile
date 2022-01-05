OUT=$(pwd)

local-build:
	docker build -f Dockerfile -t dsauer/api-tooling:latest .

local-dev:
	docker run --rm -it \
		-v $(PWD)/out:/opt/workspace \
		-v $(PWD)/tooling:/opt/tooling \
		-v $(PWD)/template:/opt/template \
		dsauer/api-tooling:latest

apit:
	echo "$(PWD)"
	docker run --rm -it \
		-v $(PWD)/out:/opt/workspace \
		dsauer/api-tooling:latest
