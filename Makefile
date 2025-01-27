CC = gcc
CFLAGS = -Wall -g
GTEST_DIR = /path/to/googletest
CPPFLAGS = -Iinclude -I$(GTEST_DIR)/include
LDFLAGS = -L$(GTEST_DIR)/lib -lgtest -lgtest_main -pthread

SRC = src/main.c src/sensor.c src/utils.c
OBJ = $(SRC:.c=.o)
EXEC = main

.PHONY: all clean test

# Default target
all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(OBJ) -o $(EXEC) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

# Run tests
test: $(EXEC)
	./$(EXEC)

clean:
	rm -f $(OBJ) $(EXEC)
