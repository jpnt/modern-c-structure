BUILD_DIR = build
CONAN_CMD = conan install . --output-folder=$(BUILD_DIR) --build=missing
MESON_SETUP_CMD = meson setup $(BUILD_DIR) --native-file nativefile.ini
MESON_BUILD_CMD = meson compile -C $(BUILD_DIR)
MESON_TEST_CMD = meson test -C $(BUILD_DIR)
EXECUTABLE = $(BUILD_DIR)/project_name_executable

# Environment Settings
export CXX = g++
export CC = gcc
export LD = mold
export PKG_CONFIG_PATH = $(BUILD_DIR) # Path to locate .pc files

.PHONY: all install_deps configure build run test clean docs

all: install_deps configure build

install_deps:
	@echo "Installing dependencies with Conan..."
	$(CONAN_CMD)

configure: install_deps
	@echo "Configuring the project with Meson..."
	$(MESON_SETUP_CMD)

build: configure
	@echo "Building the project..."
	$(MESON_BUILD_CMD)

run: build
	@echo "Running the executable..."
	$(EXECUTABLE)

test: build
	@echo "Running tests..."
	$(MESON_TEST_CMD)

docs:
	@echo "Generating documentation..."
	doxygen Doxyfile

clean:
	@echo "Cleaning build files..."
	rm -rf $(BUILD_DIR)
	rm -rf docs

rebuild: clean all
