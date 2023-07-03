cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    cmaketest
    VERSION 0.1.0
    DESCRIPTION "test cmake"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    cmaketest_cmaketest
    source/cmaketest.cpp
)
add_library(cmaketest::cmaketest ALIAS cmaketest_cmaketest)

include(GenerateExportHeader)
generate_export_header(
    cmaketest_cmaketest
    BASE_NAME cmaketest
    EXPORT_FILE_NAME export/cmaketest/cmaketest_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(cmaketest_cmaketest PUBLIC CMAKETEST_STATIC_DEFINE)
endif()

set_target_properties(
    cmaketest_cmaketest PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME cmaketest
    OUTPUT_NAME cmaketest
)

target_include_directories(
    cmaketest_cmaketest ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    cmaketest_cmaketest SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(cmaketest_cmaketest PUBLIC cxx_std_17)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${cmaketest_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT cmaketest_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of cmaketest"
  )
endif()

include(cmake/dev-mode.cmake)
