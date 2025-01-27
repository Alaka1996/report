#include "sensor.h"
#include <stdlib.h>

#define BUFFER_SIZE 10

void read_sensor_data(uint16_t *data) {
    for (int i = 0; i < BUFFER_SIZE; i++) {  // Fixed: Changed to i < BUFFER_SIZE
        data[i] = rand() % 1024;
    }
}
