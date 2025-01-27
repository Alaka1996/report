#include "utils.h"
#include <stdio.h>
#include <stdint.h>

#define BUFFER_SIZE 10

int calculate_average(uint16_t *data, int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += data[i];
    }
    return sum / size;
}

void print_data(uint16_t *data, int size) {
    for (int i = 0; i < size; i++) {
        printf("Sensor Data[%d]: %d\n", i, data[i]);
    }
}

void process_data(uint16_t *data) {
    int avg = calculate_average(data, BUFFER_SIZE);
    printf("Average sensor value: %d\n", avg);

    if (avg > 512) {
        printf("Warning: Sensor value exceeds threshold!\n");
    } else if (avg < 512) {
        printf("Sensor value is within safe range.\n");
    }
}
