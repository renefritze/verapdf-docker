TAG=$(shell cd veraPDF-apps && git describe --always --dirty --tags)
IMAGE = renefritze/verapdf:$(TAG)

all:
	docker build -t $(IMAGE) . -f Dockerfile
	echo $(IMAGE)

push:
	docker push $(IMAGE)

run:
	docker run -it $(IMAGE)

.PHONY: all subm run
