NAME     := demo
BIN      := bin/$(NAME)
VERSION  := v0.1.0
REVISION := $(shell git rev-parse --short HEAD)

SRCS    := $(shell find . -type f -name '*.go')
LDFLAGS := -ldflags="-s -w -X \"main.Version=$(VERSION)\" -X \"main.Revision=$(REVISION)\" -extldflags \"-static\""

# make or make bin/NAME
$(BIN): $(SRCS)
	go build -a -tags netgo -installsuffix netgo $(LDFLAGS) -o $(BIN)

# make deps
.PHONY: deps
deps: glide
	glide install

# make glide
.PHONY: glide
glide:
ifeq ($(shell command -v glide 2> /dev/null),)
	curl https://glide.sh/get | sh
endif

# make update-deps
.PHONY: update-deps
update-deps: glide
	glide update

# make install
.PHONY: install
install:
	glide install
	go install $(LDFLAGS)

# make run
.PHONY: run
run: $(BIN)
	@echo "Running"
	@$(BIN)

# make clean
.PHONY: clean
clean:
	rm -rf bin/*
	rm -rf vendor/*

# make test
.PHONY: test
test:
	go test -cover -v `glide novendor`
