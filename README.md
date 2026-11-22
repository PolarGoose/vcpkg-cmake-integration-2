CMake [Vcpkg](https://vcpkg.io/en/) integration.<br>
This is an alternative to [bitmeal/vcpkg-cmake-integration](https://github.com/bitmeal/vcpkg-cmake-integration).

## Features
* Very simple implementation and usage.
* Works with any `vcpkg.json` file.
* Supports Windows, Linux, and macOS

## Usage example
You should have `vcpkg.json` file where you specify dependencies and other configuration.
```
cmake_minimum_required(VERSION 3.19)

# Optional: set vcpkg configuration parameters
set(VCPKG_TARGET_TRIPLET "x64-windows" CACHE STRING "")
set(VCPKG_INSTALLED_DIR "${CMAKE_CURRENT_LIST_DIR}/build/vi" CACHE PATH "")

# Optional: specify the vcpkg version to use (tag or branch name). Default is `master`
set(VCPKG_CMAKE_INTEGRATION_VCPKG_VERSION "2025.10.17" CACHE STRING "")

# Download and include the `vcpkg.cmake` file.
include(FetchContent)
FetchContent_Populate(vcpkg_cmake_integration
                      GIT_REPOSITORY https://github.com/PolarGoose/vcpkg-cmake-integration-2.git
                      GIT_TAG v1.0)
include("${vcpkg_cmake_integration_SOURCE_DIR}/src/vcpkg.cmake")

# The "project" section must be after the `vcpkg.cmake` is included
project(my_project LANGUAGES CXX)

find_package(uchardet CONFIG REQUIRED)
add_executable(my_executable main.cpp)
target_link_libraries(my_executable PRIVATE uchardet::libuchardet)
```
