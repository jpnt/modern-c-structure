# Environment settings
export MESON ?= muon
export NINJA ?= samu
export PKG_CONFIG ?= pkgconf
export PKG_CONFIG_PATH ?= ./build
export CXX ?= g++
export CC ?= gcc
export CC_LD ?= mold

# Project settings
BUILD_DIR = build
DEPS_CMD = conan install . --output-folder=build --build=missing
SETUP_CMD = $(MESON) setup $(BUILD_DIR)
BUILD_CMD = $(NINJA) -C $(BUILD_DIR)
TEST_CMD =

EXE = my_project
SRC = ${EXE}.c
OBJ = ${SRC:.c=.o}

all: options deps build run

options:
	@echo MESON=$(MESON)
	@echo NINJA=$(NINJA)
	@echo PKG_CONFIG=$(PKG_CONFIG)
	@echo PKG_CONFIG_PATH=$(PKG_CONFIG_PATH)
	@echo CXX=$(CXX)
	@echo CC=$(CC)
	@echo CC_LD=$(CC_LD)

deps:
	@echo "Installing dependencies..."
	$(DEPS_CMD)

setup:
	@echo "Setup project..."
	$(SETUP_CMD)

build: setup
	@echo "Building project..."
	$(BUILD_CMD)

run: build
	@echo "Running executable..."
	./build/src/$(EXE)

test: build
	@echo "Running tests..."
	$(TEST_CMD)

clean:
	@echo "Cleaning build files..."
	rm -rf $(BUILD_DIR)

docs:
	@echo "Generating documentation..."
	doxygen Doxyfile

rebuild: clean all

lint:
	@echo "Formatting and performing static analysis..."
	@muon fmt
	@muon analyze -W error && echo OK

.PHONY: all options deps setup build run tests clean docs rebuild lint
