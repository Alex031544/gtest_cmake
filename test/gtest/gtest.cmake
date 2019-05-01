cmake_minimum_required(VERSION 3.0)

### gtest ENVIRONMENT ##########################################################

add_subdirectory(gtest)

### function createTest ########################################################
# ARG testname - name of the test
# ARG src2test - source file which shall be tested
# ARG testsrc  - source file with specific test definitions
function(createTest testname src2test testsrc)

  message("Tests: Create test: ${testname}")

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

  # Install executables before testing in order to make them available for
  # error investigations.
  add_custom_command(
    TARGET ${testname} POST_BUILD
    COMMENT "Install test executables to ${CMAKE_INSTALL_PREFIX}/tests"
    COMMAND
      mkdir -p ${CMAKE_INSTALL_PREFIX}/tests
    COMMAND
      cp ${CMAKE_CURRENT_BINARY_DIR}/${testname} ${CMAKE_INSTALL_PREFIX}/tests/${testname}
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
