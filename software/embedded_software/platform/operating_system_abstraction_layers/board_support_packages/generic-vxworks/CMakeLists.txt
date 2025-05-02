# ######################################################################################################################
#
# CMAKE build recipe for Generic VxWorks Board Support Package (BSP)
#
# ######################################################################################################################
set (OSAL_SYSTEM_OSTYPE "vxworks") # Bug add ing PARENT_SCOPE here won't set the variable. TODO file this bug to CMake
set (
  OSAL_SYSTEM_OSTYPE
  "${OSAL_SYSTEM_OSTYPE}"
  PARENT_SCOPE)

add_library (osal_generic-vxworks_impl OBJECT src/bsp_start.c src/bsp_console.c)

target_link_libraries (osal_generic-vxworks_impl PUBLIC osal_public_api)

# This BSP only works with "vxworks" OS layer. Confirming this reduces risk of accidental misconfiguration
set_property (TARGET osal_generic-vxworks_impl PROPERTY OSAL_EXPECTED_OSTYPE "vxworks")

target_compile_definitions (
  osal_generic-vxworks_impl PRIVATE $<TARGET_PROPERTY:osal_public_api,INTERFACE_COMPILE_DEFINITIONS>
                                    ${OSAL_USER_C_FLAGS})

target_compile_options (osal_generic-vxworks_impl PRIVATE $<TARGET_PROPERTY:osal_public_api,INTERFACE_COMPILE_OPTIONS>)
