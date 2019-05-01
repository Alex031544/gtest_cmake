# CMake-Template involving Googletest (gtest)

This project provides a CMake template which invokes gtest (googletest).

Gtest can be installed via the package manager, needs to be build and deployed
within the system:
```
# apt install -y libgtest-dev cmake
# cd /usr/src/gtest
# cmake CMakeLists.txt
# make
# cp *.a /usr/lib
```
As stated in [/1/](https://github.com/google/googletest/tree/master/googletest
"https://github.com/google/googletest/tree/master/googletest") gtest can also be
integrated into the project and build as a part of it. This can be an advantage
if the installation shown above is not an option or if there are some specific
compiler settings which differ from the standard system compiler settings.

As this is a CMake template for gtest coding syntax please refer to
[/1/](https://github.com/google/googletest/tree/master/googletest
"https://github.com/google/googletest/tree/master/googletest").

## Structure Overview

```
.
├── bin
│   ├── tests
│   │   ├── Test1_Test_cpp
│   │   ├── Test2_Test_cpp
│   │   └── Testn_Test_cpp
│   └── target_application
├── src
│   ├── Src1.cpp
│   ├── Src1.h
│   ├── Src2.cpp
│   ├── Src2.h
│   ├── Srcn.cpp
│   ├── Srcn.h
│   └── target_application.cpp
├── test
│   ├── gtest
│   │   ├── CMakeLists.txt
│   │   ├── CMakeLists.txt.in
│   │   └── gtest.cmake
│   ├── CMakeLists.txt
│   ├── Test1_Test.cpp
│   ├── Test2_Test.cpp
│   └── Testn_Test.cpp
├── LICENSE
└── CMakeLists.txt
```

## Tests

The test sources shall be stored in *./test*. Every test source must be
connected to the source to be tested in *./test/CMakeLists.txt*. Therefore
the CMake-function 'createTest' is provided in *./test/gtest/gtest.cmake* for
a more comfortable usage:
```
function(createTest testname src2test testsrc)
  ...
endfunction(createTest)
```
which has to be called as follows:
```
createTest( NameOfTheTests ../src/SourceToTest.cpp TestSource.cpp )
```

There are three different targets available:

- Standart CMake test target  

  ```
  $ make test
  Running tests...
  Test project /tmp/build
      Start 1: Test_Addition_cpp
  1/2 Test #1: Test_Addition_cpp ................   Passed    0.00 sec
      Start 2: Test_Multiply_cpp
  2/2 Test #2: Test_Multiply_cpp ................   Passed    0.00 sec

  100% tests passed, 0 tests failed out of 2

  Total Test time (real) =   0.01 sec
  ```
- A slightly more extended one, which can be used to execute testing out of
  CMake as dependency.
  ```
  $ make tests
  -- Configuring done
  -- Generating done
  -- Build files have been written to: /tmp/build/test/gtest/googletest-download
  make[1]: Entering directory '/tmp/build/test/gtest/googletest-download'
  make[2]: Entering directory '/tmp/build/test/gtest/googletest-download'
  make[3]: Entering directory '/tmp/build/test/gtest/googletest-download'
  make[3]: Leaving directory '/tmp/build/test/gtest/googletest-download'
  make[3]: Entering directory '/tmp/build/test/gtest/googletest-download'
  [ 11%] Performing update step for 'googletest'
  Current branch master is up to date.
  [ 22%] No configure step for 'googletest'
  [ 33%] No build step for 'googletest'
  [ 44%] No install step for 'googletest'
  [ 55%] No test step for 'googletest'
  [ 66%] Completed 'googletest'
  make[3]: Leaving directory '/tmp/build/test/gtest/googletest-download'
  [100%] Built target googletest
  make[2]: Leaving directory '/tmp/build/test/gtest/googletest-download'
  make[1]: Leaving directory '/tmp/build/test/gtest/googletest-download'
  Tests: Create test: Test_Addition_cpp
  Tests: Create test: Test_Multiply_cpp
  -- Configuring done
  -- Generating done
  -- Build files have been written to: /tmp/build
  [ 20%] Built target gtest
  [ 40%] Built target gtest_main
  [ 70%] Built target Test_Addition_cpp
  [100%] Built target Test_Multiply_cpp
  Test project /tmp/build/test
      Start 1: Test_Addition_cpp
  1/2 Test #1: Test_Addition_cpp ................   Passed    0.00 sec
      Start 2: Test_Multiply_cpp
  2/2 Test #2: Test_Multiply_cpp ................   Passed    0.00 sec

  100% tests passed, 0 tests failed out of 2

  Total Test time (real) =   0.01 sec
  [100%] Built target tests
  ```
- The same as above but verbose with gtest output.
  ```
  $ make tests_verbose
  [ 20%] Built target gtest
  [ 40%] Built target gtest_main
  [ 70%] Built target Test_Addition_cpp
  [100%] Built target Test_Multiply_cpp

  Scanning dependencies of target tests_verbose
  UpdateCTestConfiguration  from :/tmp/build/test/DartConfiguration.tcl
  UpdateCTestConfiguration  from :/tmp/build/test/DartConfiguration.tcl
  Test project /tmp/build/test
  Constructing a list of tests
  Done constructing a list of tests
  Updating test list for fixtures
  Added 0 tests to meet fixture requirements
  Checking test dependency graph...
  Checking test dependency graph end
  test 1
      Start 1: Test_Addition_cpp

  1: Test command: /tmp/build/test/Test_Addition_cpp
  1: Test timeout computed to be: 9.99988e+06
  1: Running main() from /tmp/build/test/gtest/googletest-src/googletest/src/gtest_main.cc
  1: [==========] Running 2 tests from 1 test suite.
  1: [----------] Global test environment set-up.
  1: [----------] 2 tests from AdditionTest
  1: [ RUN      ] AdditionTest.twoValues
  1: [       OK ] AdditionTest.twoValues (0 ms)
  1: [ RUN      ] AdditionTest.twoValuesT
  1: [       OK ] AdditionTest.twoValuesT (0 ms)
  1: [----------] 2 tests from AdditionTest (0 ms total)
  1:
  1: [----------] Global test environment tear-down
  1: [==========] 2 tests from 1 test suite ran. (0 ms total)
  1: [  PASSED  ] 2 tests.
  1/2 Test #1: Test_Addition_cpp ................   Passed    0.00 sec
  test 2
      Start 2: Test_Multiply_cpp

  2: Test command: /tmp/build/test/Test_Multiply_cpp
  2: Test timeout computed to be: 9.99988e+06
  2: Running main() from /tmp/build/test/gtest/googletest-src/googletest/src/gtest_main.cc
  2: [==========] Running 1 test from 1 test suite.
  2: [----------] Global test environment set-up.
  2: [----------] 1 test from MultiplyTest
  2: [ RUN      ] MultiplyTest.twoValues
  2: [       OK ] MultiplyTest.twoValues (0 ms)
  2: [----------] 1 test from MultiplyTest (0 ms total)
  2:
  2: [----------] Global test environment tear-down
  2: [==========] 1 test from 1 test suite ran. (0 ms total)
  2: [  PASSED  ] 1 test.
  2/2 Test #2: Test_Multiply_cpp ................   Passed    0.01 sec

  100% tests passed, 0 tests failed out of 2

  Total Test time (real) =   0.01 sec
  [100%] Built target tests_verbose
  ```

__NOTE__
As the verbose target may be to much for a regular output and the standard
CMake test output may not helpful if some test fails, all test executables will
be installed to *./bin/tests/* directly after they are build and can there be
executed separately.

__NOTE__
If `enable_testing()` is set in *./CMakeLists.txt* all tests will be performed
prior the _"target"_ application will build. This mechanism is realised as
the `tests` target becomes a dependency to the target if testing is enabled:
```
if(CMAKE_TESTING_ENABLED)
    add_dependencies( application tests )
endif()
```

# Refereces

1. https://github.com/google/googletest/tree/master/googletest
