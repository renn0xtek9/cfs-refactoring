ADD_SUBDIRECTORY (shared)



if (NOT DEFINED OSAL_SYSTEM_OSTYPE) 
  message(FATAL_ERROR "OSAL_SYSTEM_OSTYPE must be set to the appropriate OS")
endif ()

if (OSAL_EXT_SOURCE_DIR AND IS_DIRECTORY "${OSAL_EXT_SOURCE_DIR}/${OSAL_SYSTEM_OSTYPE}")
    set(OSAL_OS_SOURCE_DIR "${OSAL_EXT_SOURCE_DIR}/${OSAL_SYSTEM_OSTYPE}")
    add_subdirectory(${OSAL_OS_SOURCE_DIR})
elseif(NOT IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${OSAL_SYSTEM_OSTYPE}")
    # It is an error if the indicated OSTYPE does not correspond to a subdirectory
    # If this is not caught here then a more obfuscated error will occur later.
    message(FATAL_ERROR  "Error: No source directory found in ${CMAKE_CURRENT_SOURCE_DIR} for \"${OSAL_SYSTEM_OSTYPE}\" OS type")
endif()

set(OSAL_OS_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/${OSAL_SYSTEM_OSTYPE}")
include(add_osal_impl_library)
add_subdirectory(posix)
add_subdirectory(vxworks)


message(STATUS "OSAL Selection: ${OSAL_SYSTEM_OSTYPE} at ${OSAL_OS_SOURCE_DIR}")

set (OSAL_OS_SOURCE_DIR "${OSAL_OS_SOURCE_DIR}" PARENT_SCOPE)
