# Define the external "osal" static library target
# This is a combination of the generic parts with the low level
# system-specific parts

add_library(osal STATIC
    $<TARGET_OBJECTS:osal_shared_impl>
    $<TARGET_OBJECTS:osal_${OSAL_SYSTEM_OSTYPE}_impl>
)

# Link the OSAL with the BSP
target_link_libraries(osal PUBLIC
    osal_public_api
    osal_bsp
)
