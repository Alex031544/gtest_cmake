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


include(FetchContent)
FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

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

install(
  TARGETS
    application
  RUNTIME
  DESTINATION
    ${CMAKE_INSTALL_PREFIX}
)
