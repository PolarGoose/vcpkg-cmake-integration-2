include(FetchContent)

if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  set(VCPKG_CMAKE_INTEGRATION_VCPKG_VERSION master CACHE STRING "vcpkg Git repository tag or commit hash")

  FetchContent_Populate(vcpkg
                        GIT_REPOSITORY https://github.com/microsoft/vcpkg.git
                        GIT_TAG "${VCPKG_CMAKE_INTEGRATION_VCPKG_VERSION}"
                        SOURCE_DIR "${CMAKE_BINARY_DIR}/_deps/vcpkg-src")

  if(CMAKE_HOST_WIN32)
    execute_process(COMMAND cmd /d /c ".\\bootstrap-vcpkg.bat" -disableMetrics
                    WORKING_DIRECTORY "${vcpkg_SOURCE_DIR}"
                    COMMAND_ERROR_IS_FATAL ANY)
  else()
    execute_process(COMMAND "${vcpkg_SOURCE_DIR}/bootstrap-vcpkg.sh" -disableMetrics
                    COMMAND_ERROR_IS_FATAL ANY)
  endif()

  set(CMAKE_TOOLCHAIN_FILE "${vcpkg_SOURCE_DIR}/scripts/buildsystems/vcpkg.cmake" CACHE FILEPATH "vcpkg CMake toolchain file")
endif()
