# Compiler and Flags
CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -std=c99 -g
CXXFLAGS = -Wall -Wextra -std=c++11 -g

# Source Files
SRC = main.c sensor.c utils.c
OBJ = $(SRC:.c=.o)

# Include Directories
INCLUDE = -I./include

# GoogleTest Setup (submodule path)
GTEST_DIR = ./googletest/googletest

# Binary and Output
EXEC = program
REPORT = cppcheck_report.txt

# GoogleTest Build
GTEST_LIBS = -lgtest -lgtest_main -pthread

# Targets

# Default target to build the program
all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(OBJ) -o $(EXEC)

# Cppcheck Static Analysis
cppcheck:
	@echo "Running Cppcheck..."
	@cppcheck --enable=all --inconclusive --std=c99 $(SRC) > $(REPORT)
	@echo "Cppcheck completed. Check $(REPORT) for issues."

# GoogleTest Build and Run
test: $(OBJ)
	@echo "Running GoogleTest..."
	$(CXX) $(OBJ) -o test_program $(GTEST_DIR)/src/gtest_main.cc $(GTEST_DIR)/src/gtest-all.cc $(OBJ) -lgtest -lgtest_main -pthread $(INCLUDE)
	./test_program

# Clean Up
clean:
	rm -f $(OBJ) $(EXEC) test_program

# Rebuild the project
rebuild: clean all
