cmake_minimum_required(VERSION 3.5)

project(GtestCmake CXX) # project name and language

### BUILD SETTINGS ##########################################################

#set(CMAKE_CXX_COMPILER /usr/bin/clang )
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_EXTENSIONS OFF)

# redirect installation of gtest to
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/bin)

### TEST SETTINGS ##############################################################

enable_testing()

# only build tests if tests are enabled
if(CMAKE_TESTING_ENABLED)
    add_subdirectory(test)
endif()

### TARGET SETTINGS ############################################################

set( SOURCES
  src/Addition.cpp
  src/Multiply.cpp
)

include_directories(
    ${CMAKE_SOURCE_DIR}/src
)

add_executable( application
  src/app.cpp
  ${SOURCES}
)

# Only declare tests as dependencies if tests are enabled.
# In this case the tests will be performed prior the target will build and
# installed.
if(CMAKE_TESTING_ENABLED)
    add_dependencies( application tests )
endif()

install(
  TARGETS
    application
  RUNTIME
  DESTINATION
    ${CMAKE_INSTALL_PREFIX}
)
