# Compiler and Flags
CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -std=c99 -g -I./include
CXXFLAGS = -Wall -Wextra -std=c++11 -g -I./include

# Source Files
SRC = main.c sensor.c utils.c
OBJ = $(SRC:.c=.o)

# Binary and Output
EXEC = program
REPORT = cppcheck_report.txt

# Targets

# Default target to build the program
all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(OBJ) -o $(EXEC)

# Cppcheck Static Analysis (focus on memory issues and buffer overflows)
# Cppcheck Static Analysis
lint:
	@echo "Running cppcheck..."
	@cppcheck --enable=all --force --std=c99 $(SRC) 2>&1
	@echo "Cppcheck completed."

# Clean Up
clean:
	rm -f $(OBJ) $(EXEC) test_program

# Rebuild the project
rebuild: clean all
