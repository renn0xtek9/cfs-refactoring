# Use the supplied configuration to generate the osconfig.h file which can be referenced by the code.  This will be
# stored in the top level "inc" directory of the binary output directory
file (MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/inc")
configure_file ("${CMAKE_CURRENT_SOURCE_DIR}/osconfig.h.in" "${CMAKE_CURRENT_BINARY_DIR}/osconfig.gen" @ONLY)

# Only copy the osconfig.h into place if different from the existing file This avoids unnecessarily rebuilding all code
# in case cmake was re-run and but generated the same file.
execute_process (COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_BINARY_DIR}/osconfig.gen"
                         "${CMAKE_CURRENT_BINARY_DIR}/inc/osconfig.h")

add_library (osal_public_api INTERFACE)

# The initial set of directories that define the OSAL API This is used to initialize the interface include directory
# property of external targets
target_include_directories (
  osal_public_api INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/inc> $<INSTALL_INTERFACE:include/osal>)

if (OSAL_OMIT_DEPRECATED)
  target_compile_definitions (osal_public_api INTERFACE OSAL_OMIT_DEPRECATED)
endif (OSAL_OMIT_DEPRECATED)

if (OSAL_SYSTEM_BSPTYPE STREQUAL "generic-linux")
  target_compile_definitions (osal_public_api INTERFACE _XOPEN_SOURCE=600)

  # Linux system libraries required for the final link of applications using OSAL
  target_link_libraries (osal_public_api INTERFACE pthread dl rt)
endif ()

if (OSAL_SYSTEM_BSPTYPE STREQUAL "generic-vxworks")
  # The "-u" switch is required to ensure that the linker pulls in the OS_BSPMain entry point
  target_link_libraries (osal_public_api INTERFACE -uOS_BSPMain)
endif ()

if (OSAL_INSTALL_LIBRARIES)
  include (CMakePackageConfigHelpers)

  # TODO use include interface of targets here !
  install (DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/inc/ ${CMAKE_CURRENT_BINARY_DIR}/inc/ DESTINATION include/osal)

endif ()
