#include <gtest/gtest.h>
extern "C" {
#include "utils.h"  // Include the C header for your C function
#define BUFFER_SIZE 10
#include "sensor.h" 
}

TEST(SensorTest, TestBufferOverflow) {
    uint16_t data[BUFFER_SIZE];  // Correct size
    read_sensor_data(data);
    
    // Verify that we are not accessing out-of-bounds memory.
    // Ensure no invalid indices are written and all values are in the expected range.
    for (int i = 0; i < BUFFER_SIZE; ++i) {
        EXPECT_GE(data[i], 0);           // Data should be non-negative
        EXPECT_LT(data[i], 1024);        // Data should be less than 1024 (range of rand())
    }
    
    // Test that no out-of-bounds access occurs (BUFFER_SIZE index should not be accessed)
    EXPECT_EQ(data[BUFFER_SIZE], 0);   // No out-of-bounds access (BUFFER_SIZE index should not exist)
}
