cmake_minimum_required(VERSION 3.0)

include(${CMAKE_SOURCE_DIR}/test/gtest.cmake)

### set sources to test ########################################################
include_directories(${CMAKE_SOURCE_DIR}/src)

### create all tests ###########################################################

createTest( Test_Addition_cpp ../src/Addition.cpp Addition_Test.cpp )
createTest( Test_Multiply_cpp ../src/Multiply.cpp Multiply_Test.cpp )
