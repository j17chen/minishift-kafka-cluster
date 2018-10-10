

SUBDIR:=common zookeeper kafka

.PHONY: build
build:
		for dir in $(SUBDIR); do $(MAKE) build -C $$dir;done
.PHONY: clean
clean:
		for dir in $(SUBDIR); do $(MAKE) clean -C $$dir;done

