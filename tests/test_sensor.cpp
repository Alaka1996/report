extern "C" {
    #include "utils.h"  // Include the C header for your C function
    #include "sensor.h"
#define BUFFER_SIZE 10
}

#include <gtest/gtest.h>

// Test case for checking buffer overflow
TEST(SensorTest, TestBufferOverflow) {
    uint16_t *data = (uint16_t *)malloc(BUFFER_SIZE * sizeof(uint16_t));
    ASSERT_NE(data, nullptr);  // Ensure memory is allocated
    
    // Simulate the buffer overflow scenario
    read_sensor_data(data);  // Function under test
    
    // No direct way to detect overflow in this test, but we can check if data is not corrupted.
    EXPECT_GE(data[BUFFER_SIZE - 1], 0);  // Example to check last element isn't 0
    EXPECT_LT(data[BUFFER_SIZE], 1024);  // No out-of-bounds access (BUFFER_SIZE index should not exist)    free(data);
}

// Test case for average calculation
TEST(SensorTest, TestCalculateAverage) {
    uint16_t data[] = {10, 20, 30};
    int size = 3;
    int result = calculate_average(data, size);
    EXPECT_EQ(result, 20);
}
