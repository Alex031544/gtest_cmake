
### gtest ENVIRONMENT ##########################################################

# Locate GTest (package libgtest-dev must be installed)
find_package(GTest REQUIRED)
#include_directories(${GTEST_INCLUDE_DIRS})

# add sources of libgtest-dev and tell CMake to build it into the subfolder
# libgtest (this CMakeLists.txt provides the target gtest)
add_subdirectory(/usr/src/gtest libgtest)
# add this library
link_directories(${PROJECT_BINARY_DIR}/test/libgtest)

### function createTest ########################################################
# ARG testname - name of the test
# ARG src2test - source file which shall be tested
# ARG testsrc  - source file with specific test definitions
function(createTest testname src2test testsrc)

  add_executable( ${testname}
    ${src2test}
    ${testsrc}
  )

  add_dependencies( ${testname}
    gtest
    gtest_main
  )

  target_link_libraries( ${testname}
    pthread
    gtest
    gtest_main
  )

  # add the test to the cmake test list
  add_test(
    NAME
      ${testname}
    COMMAND
      ${CMAKE_CURRENT_BINARY_DIR}/${testname}
  )

  # collect all tests to the test targets
  add_dependencies( tests
    ${testname}
  )

  add_dependencies( tests_verbose
    ${testname}
  )

  # all test executeables shall be installed in a common test folder
  install(
    TARGETS
      ${testname}
    RUNTIME
    DESTINATION
      ${CMAKE_INSTALL_PREFIX}/tests
  )

endfunction(createTest)

### add a target which execute all tests with verbose output ###################
add_custom_target(
  tests_verbose
  COMMAND
    ${CMAKE_CTEST_COMMAND} --verbose
)

add_custom_target(
  tests
  COMMAND
    ${CMAKE_CTEST_COMMAND}
)
