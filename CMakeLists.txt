cmake_minimum_required (VERSION 4.0)
set (MISSION_NAME "Flight Software")
set (GLOBAL_VERSION 0.0.1)
project (${MISSION_NAME} VERSION ${GLOBAL_VERSION})
enable_testing ()
list (APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/)

include (GNUInstallDirs)
include (CMakeDependencyDiagrams)

set (CMAKE_SKIP_INSTALL_RPATH TRUE)
set (INSTALL_RPATH_USE_LINK_PATH TRUE)

add_subdirectory (software)
