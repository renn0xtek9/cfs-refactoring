cmake_minimum_required (VERSION 4.0)
set (MISSION_NAME "Flight Software")
set (GLOBAL_VERSION 0.0.1)
project (${MISSION_NAME} VERSION ${GLOBAL_VERSION})
enable_testing ()
# FIND_PROGRAM (CONAN conan) EXECUTE_PROCESS ( WORKING_DIRECTORY ${CMAKE_BINARY_DIR} COMMAND ${CONAN} install
# ${CMAKE_SOURCE_DIR}/conanfile.txt --profile:build=${CMAKE_SOURCE_DIR}/conan_profiles/linux-x86
# --profile:host=${CMAKE_SOURCE_DIR}/conan_profiles/linux-x86 --build missing COMMAND_ERROR_IS_FATAL ANY)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/)

# INCLUDE (${CMAKE_BINARY_DIR}/conanbuildinfo.cmake) CONAN_BASIC_SETUP (PROFILE
# ${CMAKE_SOURCE_DIR}/conan_profiles/linux-x86)

include (GNUInstallDirs)
# INCLUDE (AddLibraryUnitTest) INCLUDE (CreateLibrary)
enable_testing ()
set (CMAKE_SKIP_INSTALL_RPATH TRUE)
set (INSTALL_RPATH_USE_LINK_PATH TRUE)

# ADD_SUBDIRECTORY (documentation)
add_subdirectory (software)

# ADD_SUBDIRECTORY (packaging)
