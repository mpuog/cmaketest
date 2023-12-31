cmake_minimum_required(VERSION 3.14)

project(cmaketestTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)
include(../cmake/windows-set-path.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(cmaketest REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(cmaketest_test source/cmaketest_test.cpp)
target_link_libraries(cmaketest_test PRIVATE cmaketest::cmaketest)
target_compile_features(cmaketest_test PRIVATE cxx_std_17)

add_test(NAME cmaketest_test COMMAND cmaketest_test)
windows_set_path(cmaketest_test cmaketest::cmaketest)

# ---- End-of-file commands ----

add_folders(Test)
