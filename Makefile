# Makefile for building and cleaning the project using CMake

# Variables
BUILD_DIR = build
CMAKE = cmake
MAKE = make

# Default target (build the project)
all: $(BUILD_DIR)/CMakeCache.txt
	@echo "Building the project..."
	@$(MAKE) -C $(BUILD_DIR)

$(BUILD_DIR)/CMakeCache.txt:
	@echo "Configuring CMake..."
	@mkdir -p $(BUILD_DIR)
	@$(CMAKE) -S . -B $(BUILD_DIR)

clean:
	@echo "Cleaning the project..."
	@rm -rf $(BUILD_DIR)

# Phony targets
.PHONY: all clean
