cmake_minimum_required(VERSION 3.15)

### set sources to test ########################################################
include_directories(${CMAKE_SOURCE_DIR}/src)

### prepare test environment ###################################################
enable_testing()
include(GoogleTest)


### collect tests ############################################################

add_executable(
        Test_Addition_cpp
        ../src/Addition.cpp
        Addition_Test.cpp
)

target_link_libraries(
        Test_Addition_cpp
        gtest_main
)

gtest_discover_tests(Test_Addition_cpp)


add_executable(
        Test_Multiply_cpp
        ../src/Multiply.cpp
        Multiply_Test.cpp
)

target_link_libraries(
        Test_Multiply_cpp
        gtest_main
)

gtest_discover_tests(Test_Multiply_cpp)
