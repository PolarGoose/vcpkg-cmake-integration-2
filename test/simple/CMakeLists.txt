cmake_minimum_required(VERSION 3.19)

include("${CMAKE_CURRENT_SOURCE_DIR}/../../src/vcpkg.cmake")

project(simple_test LANGUAGES CXX)

find_package(uchardet CONFIG REQUIRED)

add_executable(simple_test main.cpp)
target_link_libraries(simple_test PRIVATE uchardet::libuchardet)
