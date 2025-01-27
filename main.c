#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "sensor.h"
#include "utils.h"

#define BUFFER_SIZE 10

void main() {
    uint16_t *sensor_data = (uint16_t *)malloc(BUFFER_SIZE);  
    if (!sensor_data) {
        printf("Memory allocation failed!\n");
        return;
    }

    read_sensor_data(sensor_data);
    process_data(sensor_data);
    print_data(sensor_data, BUFFER_SIZE);

    free(sensor_data);  // Free allocated memory
    return 0;
}
