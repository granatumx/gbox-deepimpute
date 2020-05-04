VER = 2.0.0
GBOX = granatumx/gbox-deepimpute:$(VER)

docker:
	docker build --build-arg VER=$(VER) --build-arg GBOX=$(GBOX) -t $(GBOX) .

docker-push:
	docker push $(GBOX)

shell:
	docker run -it $(GBOX) /bin/bash

doc:
