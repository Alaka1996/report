CC = gcc
CXX = g++
CFLAGS = -Wall -g
GTEST_DIR = third_party/googletest/googletest  # Path to GoogleTest submodule
CPPFLAGS = -Iinclude -I$(GTEST_DIR)/include
LDFLAGS = -L$(GTEST_DIR)/lib -lgtest -lgtest_main -pthread

SRC = src/main.c src/sensor.c src/utils.c
OBJ = $(SRC:.c=.o)
EXEC = main
TEST_OBJ = tests/test_main.o

# Default target
all: $(EXEC)

# Rule to build the executable
$(EXEC): $(OBJ)
	$(CC) $(OBJ) -o $(EXEC) $(LDFLAGS)

# Rule to build the test object file
tests/test_main.o: tests/test_main.cpp
	$(CXX) $(CPPFLAGS) -c $< -o $@

# Run tests using Google Test framework
test: $(EXEC) tests/test_main.o
	$(CXX) $(TEST_OBJ) $(OBJ) -o run_tests $(LDFLAGS)
	./run_tests

# Run cppcheck for static code analysis
cppcheck:
	@cppcheck --enable=all --inconclusive --force --quiet .

# Build GoogleTest (only once after cloning or pulling the submodule)
build_gtest:
	cd $(GTEST_DIR) && cmake . && make

# Clean target to remove generated files
clean:
	rm -f $(OBJ) $(EXEC) tests/test_main.o run_tests
