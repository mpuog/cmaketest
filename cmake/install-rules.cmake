if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/cmaketest-${PROJECT_VERSION}"
      CACHE PATH ""
  )
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package cmaketest)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT cmaketest_Development
)

install(
    TARGETS cmaketest_cmaketest
    EXPORT cmaketestTargets
    RUNTIME #
    COMPONENT cmaketest_Runtime
    LIBRARY #
    COMPONENT cmaketest_Runtime
    NAMELINK_COMPONENT cmaketest_Development
    ARCHIVE #
    COMPONENT cmaketest_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    cmaketest_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(cmaketest_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${cmaketest_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT cmaketest_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${cmaketest_INSTALL_CMAKEDIR}"
    COMPONENT cmaketest_Development
)

install(
    EXPORT cmaketestTargets
    NAMESPACE cmaketest::
    DESTINATION "${cmaketest_INSTALL_CMAKEDIR}"
    COMPONENT cmaketest_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
