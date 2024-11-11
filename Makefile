# Environment settings
export MESON ?= meson
export NINJA ?= samu
export PKG_CONFIG ?= pkgconf
# export PKG_CONFIG_PATH ?= ./build
export CXX ?= g++
# export CXXFLAGS ?= 
export CC ?= gcc
# export CFLAGS ?=
export CC_LD ?= mold
# export LDFLAGS ?=

# Directories
BUILD_DIR = build
SRC_DIR = src
TESTS_DIR = tests

# Commands
SETUP_CMD = $(MESON) setup $(BUILD_DIR)
BUILD_CMD = $(NINJA) -C $(BUILD_DIR)
CPPCHECK_CMD = cppcheck --enable=all --inconclusive --error-exitcode=1
VALGRIND_CMD = valgrind --leak-check=full --track-origins=yes --show-reachable=yes -s

# Files
EXE = my_project
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst %.c,%.o,$(SRC))

.PHONY: all options setup build run tests clean docs rebuild cppcheck valgrind install uninstall

all: options build

options:
	@echo MESON=$(MESON)
	@echo NINJA=$(NINJA)
	@echo PKG_CONFIG=$(PKG_CONFIG)
	@echo PKG_CONFIG_PATH=$(PKG_CONFIG_PATH)
	@echo CXX=$(CXX)
	@echo CC=$(CC)
	@echo CC_LD=$(CC_LD)
	@echo CPPFLAGS=$(CPPFLAGS)
	@echo LDFLAGS=$(LDFLAGS)

setup:
	@echo "Setup project..."
	$(SETUP_CMD)

build: setup
	@echo "Building project..."
	$(BUILD_CMD)

run: build
	@echo "Running executable..."
	./$(BUILD_DIR)/src/$(EXE)

test: build
	@echo "Running tests..."
	@echo TODO

clean:
	@echo "Cleaning build files..."
	rm -rf $(BUILD_DIR)

docs:
	@echo "Generating documentation..."
	doxygen Doxyfile

rebuild: clean all

cppcheck:
	@echo "Running cppcheck..."
	$(CPPCHECK_CMD) $(SRC_DIR)

valgrind:
	@echo "Running valgrind..."
	$(VALGRIND_CMD) ./$(BUILD_DIR)/src/$(EXE)

install:
	@echo "Installing project..."
	@echo TODO

uninstall:
	@echo "Uninstalling project..."
	@echo TODO
