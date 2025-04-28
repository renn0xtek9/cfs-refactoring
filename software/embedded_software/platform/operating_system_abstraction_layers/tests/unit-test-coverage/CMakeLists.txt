# CMake build script for OSAL white-box coverage tests
#
# IMPORTANT: This is currently implemented as a completely separate project
# from OSAL itself and it is not connected to the normal OSAL build in any way.
# To run coverage tests this must be built separately.  There are several reasons
# for having it this way:
#    - Not all targets have coverage testing implemented (yet).  Only VxWorks right now.
#    - It may use an entirely different toolchain than the actual target build.
#       (coverage tests run with the "real" calls stubbed out, so they can be executed
#        on any platform/os - case in point, the VxWorks coveraged paths can be analyzed
#        by running the code on Linux using the specially-crafted inputs)
#    - By definition this MUST completely rebuild OSAL to add the requisite "coverage"
#      options so that the binaries include the extra instrumentation.
#
#  NO ARTEFACTS FROM THIS BUILD SHOULD EVER INTERMINGLE WITH THE REAL TARGET BUILD
#

project(OSALCOVERAGE C)

# Ask to generate a "make test" target
enable_testing()

# The following logic is borrowed from the real OSAL build
# One difference here is that the UT BSP/framework and target OSTYPE need not "match"
# The following cache variables are recognized:
#   OSALCOVERAGE_TARGET_OSTYPE  -> the intended OSAL that runs on the actual target
#
# The currently supported setup is to use the configured BSP to execute all available
# code coverage analysis.  Because the actual underlying OS calls are stubbed out, there
# is no dependency on the actual underlying OS.  Note that RTEMS is not included as the
# coverage test is not implemented at this time.
set(OSALCOVERAGE_TARGET_OSTYPE "vxworks;shared" CACHE STRING "OSAL target(s) to build coverage tests for (default=all)")

# Check that coverage has been implemented for this OSTYPE
foreach(OSTYPE ${OSALCOVERAGE_TARGET_OSTYPE})
    if (NOT IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${OSTYPE})
      message(FATAL_ERROR "No coverage tests implemented for ${OSTYPE}")
    endif (NOT IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${OSTYPE})
endforeach(OSTYPE ${OSALCOVERAGE_TARGET_OSTYPE})

message(STATUS "Coverage Test Target OS: ${OSALCOVERAGE_TARGET_OSTYPE}")

add_subdirectory(ut-stubs)

include (add_coverage_testrunner)

#TODO @renn0xtek move setname to OSTYPE like above !
foreach(SETNAME ${OSALCOVERAGE_TARGET_OSTYPE})
    add_subdirectory(${SETNAME})
endforeach(SETNAME ${OSALCOVERAGE_TARGET_OSTYPE})
