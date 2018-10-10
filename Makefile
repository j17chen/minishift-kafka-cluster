

SUBDIR:=docker

.PHONY: build
build:
		for dir in $(SUBDIR); do $(MAKE) build -C $$dir;done
.PHONY: clean
clean:
		for dir in $(SUBDIR); do $(MAKE) clean -C $$dir;done
.PHONY: test
test:build
		oc delete all --all
		oc apply -f kafka-cluster-template.yaml
