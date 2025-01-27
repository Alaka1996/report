# Compiler and Flags
CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -std=c99
CXXFLAGS = -Wall -Wextra -std=c++11
LDFLAGS = -pthread

# Directories
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build
TEST_DIR = tests
GTEST_DIR = third_party/googletest

# Files
SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))
TEST_SOURCES = $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJECTS = $(patsubst $(TEST_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(TEST_SOURCES))
TARGET = $(BUILD_DIR)/main
TEST_TARGET = $(BUILD_DIR)/tests

# Rules
all: $(TARGET)

# Build main program
$(TARGET): $(OBJECTS)
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@

# Compile source files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(INC_DIR)/%.h
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $@

# Build tests
tests: $(TEST_TARGET)

$(TEST_TARGET): $(TEST_OBJECTS) $(GTEST_DIR)/googletest
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(TEST_OBJECTS) -I$(INC_DIR) -I$(GTEST_DIR)/googletest/include \
	$(GTEST_DIR)/build/lib/libgtest.a $(GTEST_DIR)/build/lib/libgtest_main.a -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(TEST_DIR)/%.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(INC_DIR) -I$(GTEST_DIR)/googletest/include -c $< -o $@

# Run tests
test: tests
	$(TEST_TARGET)

# Run Cppcheck
cppcheck:
	cppcheck --enable=all --inconclusive --std=c99 --verbose --force $(SRC_DIR) $(INC_DIR)

# Clean
clean:
	rm -rf $(BUILD_DIR)
