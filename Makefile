# Environment settings
MESON ?= muon
NINJA ?= samu
PKG_CONFIG ?= pkgconf
CXX ?= g++
CC ?= gcc
CC_LD ?= mold

# Project settings
BUILD_DIR = build
SETUP_CMD = $(MESON) setup $(BUILD_DIR)
BUILD_CMD = $(NINJA) -C $(BUILD_DIR)
TEST_CMD =

EXE = my_project
SRC = ${EXE}.c
OBJ = ${SRC:.c=.o}

all: build run

deps:
	@echo "Installing dependencies..."
	# TODO

configure:
	@echo "Configuring project..."
	$(SETUP_CMD)

build: configure
	@echo "Building project..."
	$(BUILD_CMD)

run: build
	@echo "Running executable..."
	./build/src/$(EXE)

test: build
	@echo "Running tests..."
	$(TEST_CMD)

docs:
	@echo "Generating documentation..."
	doxygen Doxyfile

clean:
	@echo "Cleaning build files..."
	rm -rf $(BUILD_DIR)
	rm -rf docs

rebuild: clean all

lint:
	@echo "Formatting and performing static analyze..."
	@muon fmt
	@muon analyze

.PHONY: all configure build run test clean docs rebuild lint
