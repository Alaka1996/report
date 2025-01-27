CC = gcc
CFLAGS = -Iinclude -Wall -Wextra -std=c99
SRCS = src/main.c src/sensor.c src/utils.c
OBJS = $(SRCS:.c=.o)
TARGET = main

.PHONY: all clean cppcheck test

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

cppcheck:
	cppcheck --enable=all --suppress=missingIncludeSystem src include

test:
	@mkdir -p build
	@g++ -Iinclude tests/test_main.cpp -o build/test_main -lgtest -lpthread
	@./build/test_main

clean:
	rm -f $(OBJS) $(TARGET)
	rm -rf build
