if (OSAL_EXT_SOURCE_DIR AND IS_DIRECTORY "${OSAL_EXT_SOURCE_DIR}/${OSAL_SYSTEM_BSPTYPE}")
  add_subdirectory (${OSAL_EXT_SOURCE_DIR}/${OSAL_SYSTEM_BSPTYPE})
elseif (IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${OSAL_SYSTEM_BSPTYPE}")
  set (OSAL_BSP_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${OSAL_SYSTEM_BSPTYPE})
  add_subdirectory (${OSAL_BSP_SOURCE_DIR})
else ()
  # It is an error if the indicated BSPTYPE does not correspond to a subdirectory If this is not caught here then a more
  # obfuscated error will occur later.
  message (
    FATAL_ERROR
      "Error: No source directory found in ${CMAKE_CURRENT_SOURCE_DIR} for \"${OSAL_SYSTEM_BSPTYPE}\" BSP type")
endif ()
message (STATUS "BSP Selection: ${OSAL_SYSTEM_BSPTYPE} at ${OSAL_BSP_SOURCE_DIR}")

set (
  OSAL_SYSTEM_OSTYPE
  "${OSAL_SYSTEM_OSTYPE}"
  PARENT_SCOPE)
set (
  OSAL_BSP_SOURCE_DIR
  "${OSAL_BSP_SOURCE_DIR}"
  PARENT_SCOPE)
