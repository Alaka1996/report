#include "gtest/gtest.h"
#include "utils.h"

TEST(UtilsTest, CalculateAverage) {
    uint16_t data[5] = {10, 20, 30, 40, 50};
    EXPECT_EQ(calculate_average(data, 5), 30);
}

TEST(UtilsTest, PrintData) {
    uint16_t data[3] = {100, 200, 300};
    testing::internal::CaptureStdout();
    print_data(data, 3);
    std::string output = testing::internal::GetCapturedStdout();
    EXPECT_NE(output.find("Sensor Data[0]: 100"), std::string::npos);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
