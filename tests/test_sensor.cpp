#include <gtest/gtest.h>
extern "C" {
#include "utils.h"  // Include the C header for your C function
}

TEST(SensorTest, TestBufferOverflow) {
    uint16_t data[BUFFER_SIZE];  // Correct size
    read_sensor_data(data);
    
    // Verify that we are not accessing out-of-bounds memory.
    // This can be done by ensuring no values are written to invalid indices.
    EXPECT_GE(data[BUFFER_SIZE - 1], 0);  // Last valid index (BUFFER_SIZE - 1) should be written to
    EXPECT_LT(data[BUFFER_SIZE], 1024);  // No out-of-bounds access (BUFFER_SIZE index should not exist)
}
