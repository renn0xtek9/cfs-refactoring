set (
  OSAL_SRCLIST
  src/osapi-binsem.c
  src/osapi-clock.c
  src/osapi-common.c
  src/osapi-condvar.c
  src/osapi-countsem.c
  src/osapi-dir.c
  src/osapi-errors.c
  src/osapi-file.c
  src/osapi-filesys.c
  src/osapi-heap.c
  src/osapi-idmap.c
  src/osapi-module.c
  src/osapi-mutex.c
  src/osapi-network.c
  src/osapi-printf.c
  src/osapi-queue.c
  src/osapi-select.c
  src/osapi-shell.c
  src/osapi-sockets.c
  src/osapi-task.c
  src/osapi-timebase.c
  src/osapi-time.c
  src/osapi-version.c)

if (OSAL_CONFIG_DEBUG_PRINTF)
  list (APPEND OSAL_SRCLIST src/osapi-debug.c)
endif (OSAL_CONFIG_DEBUG_PRINTF)

add_library (osal_shared_impl OBJECT)

target_sources (
  osal_shared_impl
  PRIVATE ${OSAL_SRCLIST}
  INTERFACE
    FILE_SET
    public_headers
    TYPE
    HEADERS
    BASE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/
    FILES
    inc/os-shared-binsem.h
    inc/os-shared-condvar.h
    inc/os-shared-dir.h
    inc/os-shared-filesys.h
    inc/os-shared-idmap.h
    inc/os-shared-network.h
    inc/os-shared-select.h
    inc/os-shared-task.h
    inc/os-shared-clock.h
    inc/os-shared-console.h
    inc/os-shared-errors.h
    inc/os-shared-globaldefs.h
    inc/os-shared-module.h
    inc/os-shared-printf.h
    inc/os-shared-shell.h
    inc/os-shared-timebase.h
    inc/os-shared-common.h
    inc/os-shared-countsem.h
    inc/os-shared-file.h
    inc/os-shared-heap.h
    inc/os-shared-mutex.h
    inc/os-shared-queue.h
    inc/os-shared-sockets.h
    inc/os-shared-time.h)
target_include_directories (
  osal_shared_impl
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
  INTERFACE $<INSTALL_INTERFACE:include/osal>)

target_compile_definitions (osal_shared_impl PRIVATE ${OSAL_USER_C_FLAGS})
target_link_libraries (osal_shared_impl PUBLIC osal_public_api)
