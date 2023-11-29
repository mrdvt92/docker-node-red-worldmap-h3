CONTAINER_NAME=node-red-worldmap-h3
IMAGE_NAME=node-red-worldmap-h3
FLOWS_FILE=flows.json
FLOWS_PATH=/data
CONTAINER_TZ=America/New_York
EXTERNAL_PORT=1881

all:
	@echo

export_flows:
	#requires settings.js flowFilePretty: true,
	docker exec -it $(CONTAINER_NAME) cat $(FLOWS_PATH)/$(FLOWS_FILE) > $(FLOWS_FILE)
	dos2unix $(FLOWS_FILE)
	sed -i '$$a\' $(FLOWS_FILE)

restart:	stop rm run start

start:
	docker start $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME)

rm:
	docker rm $(CONTAINER_NAME)

run:
	docker run -d -p $(EXTERNAL_PORT):1880 --name $(CONTAINER_NAME) -e TZ=$(CONTAINER_TZ) -e NODE_TLS_REJECT_UNAUTHORIZED=0 --restart=unless-stopped $(IMAGE_NAME)

build:
	docker build -t $(IMAGE_NAME) .

bash:
	docker exec -it $(CONTAINER_NAME) /bin/bash

