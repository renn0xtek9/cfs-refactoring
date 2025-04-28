######################################################################
#
# CMAKE build recipe for Operating System Abstraction Layer (OSAL)
#
######################################################################
#
# This defines the following target(s):
#
# osal_public_api : Interface library that refers to the OSAL public API only.
#                   This may be used for applications that need to use the
#                   OSAL-provided types (such as common-types.h) but do not
#                   make any OSAL API calls.
#
#         osal   : The main library containing the OSAL binary code.  This is
#                  the normal library that applications should link to.
#                  This is built based off the OSAL_SYSTEM_OSTYPE selection
#
#     osal_bsp   : The board support library containing the system-
#                  specific entry point function (e.g. main) and the
#                  file system volume table for the target board.
#                  This is based off the OSAL_SYSTEM_BSPTYPE selection
#
#    ut_assert   : The unit test support library.  This implements
#                  an application entry point (OS_Application_Startup)
#                  that contains a unit test subsystem.  This uses
#                  the OSAL BSP to provide system-specific entry point.
#                  Linking with this library also links with osal_bsp,
#                  but not necessarily the osal library itself.
#
# ut_coverage_compile : an interface target that contains the
#                       compiler options/definitions to enable coverage
#                       instrumentation in the generated objects.  It should
#                       be specified on files compiled for coverage analysis.
#
# ut_coverage_link    : an interface target that contains options/definitions
#                       and any link libraries to enable coverage instrumentation in
#                       the final executable.   It should be specified on coverage
#                       test executable targets.
#
#
# The following options and variables will customize the build:
#
# OSAL_SYSTEM_BSPTYPE: Should be set by the caller to indicate the type of
#                  BSP to build.  This is a minimal platform-specific shim
#                  layer to aid with startup and shutdown.  This implies a
#                  value for OSTYPE (see below).
#
# OSAL_SYSTEM_OSTYPE: The selected OS abstraction type (posix, vxworks, rtems).
#                  Normally this setting is not needed to be configured as it is
#                  inferred from the BSP type.
#
# OSAL_INSTALL_LIBRARIES : Boolean, enables "install" of targets listed above such
#                  that libraries and public API header files are copied into the system
#                  location specified by CMAKE_INSTALL_PREFIX.  This set of headers
#                  and link libraries can then be used to compile other applications
#                  separately from OSAL.  Default is "ON" when OSAL is being compiled
#                  standalone (i.e. cmake called directly on the OSAL source dir).
#                  Default is "OFF" when OSAL is included via 'add_subdirectory' in
#                  a parent application project such as CFE/CFS.
#
# ENABLE_UNIT_TESTS : Boolean, enables build of the unit tests (coverage and functional)
#
# OSAL_OMIT_DEPRECATED : Boolean, Compile without deprecated or obsolete features for
#                  forward compatibility testing.  Any features marked as deprecated
#                  will be disabled, allowing developers to test software based
#                  only on currently-supported software features and patterns.
#
# OSAL_EXT_SOURCE_DIR : External source directory to check for BSP/OS implementation
#
# Additionally the following target is defined if ENABLE_UNIT_TESTS
# is set TRUE:
#
# ut_osapi_stubs : Stub library correlating to the OSAL public API
#                  This is for unit testing OSAL-based applications
#                  It operates in conjunction with the ut_assert library.
#
# For backward compatibility with previous versions, this also exports the following
# variables.  Code which is depending on these values should migrate to using the
# interfaces of the provide ut_coverage_compile/link targets instead.
#
#  UT_COVERAGE_COMPILE_FLAGS : Compiler flags that must be used to
#                  instrument code for coverage testing
#  UT_COVERAGE_LINK_FLAGS : Linker flags that must be used to
#                  instrument code for coverage testing
#
# The ENABLE_UNIT_TESTS option also builds a set of test applications from
# that demonstrate the usage and validate the runtime behavior of various
# OSAL resources.
#
######################################################################


# Set the policy dictating use of target_link_libraries across directories
# Either OLD or NEW should work here but setting it to something avoids a
# warning when using newer versions of the tool.
if (CMAKE_VERSION VERSION_GREATER 3.13) #done
    cmake_policy(SET CMP0079 NEW) 
endif()

option(OSAL_VALIDATE_API "Validate the OSAL API headers as part of the build" OFF)

set(OSAL_LANG C)
if (OSAL_VALIDATE_API)
    list(APPEND OSAL_LANG CXX)
endif()

project(OSAL ${OSAL_LANG})
# define a custom property to track relationship between BSP and OS
# this should be set on BSP "impl" targets to indicate the correct OS impl to go with it
define_property(TARGET PROPERTY OSAL_EXPECTED_OSTYPE
    BRIEF_DOCS
        "The expected OS type for an OSAL BSP implementation"
    FULL_DOCS
        "This property is used to indicate the OS implementation layer that is intended to be paired with the BSP implementation"
)

include("${OSAL_SOURCE_DIR}/default_config.cmake")

foreach(CONFIG ${OSAL_CONFIGURATION_FILE}) 
    include(${CONFIG})
endforeach(CONFIG OSAL_CONFIGURATION_FILE)




ADD_SUBDIRECTORY (osal_public_api)

if (NOT DEFINED OSAL_SYSTEM_BSPTYPE)
message(STATUS "OSAL_SYSTEM_BSPTYPE not defined, no OSAL implementation will be compiled")
return()
endif ()

<<<<<<< HEAD
=======
add_subdirectory (board_support_packages)
add_subdirectory (operating_systems)
add_subdirectory (osal_bsp)
add_subdirectory (osal)
>>>>>>> 8be0f72 (Board support packageS)

ADD_SUBDIRECTORY(board_support_package)
ADD_SUBDIRECTORY (operating_systems)
ADD_SUBDIRECTORY (osal_bsp)
ADD_SUBDIRECTORY (osal)


include("${OSAL_BSP_SOURCE_DIR}/build_options.cmake" OPTIONAL)
include("${OSAL_OS_SOURCE_DIR}/build_options.cmake" OPTIONAL)

get_target_property(OSAL_PUBLIC_API_COMPILE_DEFINITIONS osal_public_api INTERFACE_COMPILE_DEFINITIONS)
message(STATUS "OSAL Compile Definitions: ${OSAL_PUBLIC_API_COMPILE_DEFINITIONS}")



if (BUILD_TESTING)
    add_subdirectory(tests)
endif()



if (OSAL_INSTALL_LIBRARIES)
    include(CMakePackageConfigHelpers)

    # Install and also export this library, so it can be found via
    # "find_package()" from some other CMake build
    install(
        TARGETS osal_public_api osal_bsp osal
        EXPORT nasa-osal-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        PUBLIC_HEADER DESTINATION include/osal
        INCLUDES DESTINATION include/osal
    )
    install(EXPORT nasa-osal-export
        FILE NasaOsalTargets.cmake
        DESTINATION lib/cmake
    )
    configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/NasaOsalConfig.cmake.in
        "${CMAKE_CURRENT_BINARY_DIR}/NasaOsalConfig.cmake"
        INSTALL_DESTINATION lib/cmake
    )
    install(FILES
        "${CMAKE_CURRENT_BINARY_DIR}/NasaOsalConfig.cmake"
        DESTINATION lib/cmake
    )

endif()
