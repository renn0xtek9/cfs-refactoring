set (BSP_SRCLIST src/osapi-bsp.c src/bsp_default_app_run.c src/bsp_default_app_startup.c src/bsp_default_symtab.c
                 src/bsp_default_resourcecfg.c)

# Define the external "osal_bsp" static library target
add_library (osal_bsp STATIC ${BSP_SRCLIST} $<TARGET_OBJECTS:osal_${OSAL_SYSTEM_BSPTYPE}_impl>)

target_link_libraries (osal_bsp PUBLIC osal_public_api)

target_include_directories (osal_bsp PRIVATE inc)

target_compile_definitions (osal_bsp PRIVATE ${OSAL_USER_C_FLAGS})
