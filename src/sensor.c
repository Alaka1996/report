#include "sensor.h"
#include <stdlib.h>
#include <stdio.h>

void read_sensor_data(uint16_t *data) {
    for (int i = 0; i < BUFFER_SIZE; i++) {
        data[i] = rand() % 1024;
    }
}
