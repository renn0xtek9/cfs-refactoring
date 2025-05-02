add_library (
  ut_vxworks_impl_stubs
  src/vxworks-os-impl-binsem-stubs.c
  src/vxworks-os-impl-common-stubs.c
  src/vxworks-os-impl-countsem-stubs.c
  src/vxworks-os-impl-dir-stubs.c
  src/vxworks-os-impl-file-stubs.c
  src/vxworks-os-impl-idmap-stubs.c
  src/vxworks-os-impl-module-stubs.c
  src/vxworks-os-impl-mutex-stubs.c
  src/vxworks-os-impl-queue-stubs.c
  src/vxworks-os-impl-sockets-stubs.c
  src/vxworks-os-impl-task-stubs.c
  src/vxworks-os-impl-timer-stubs.c)

get_target_property (OSAL_OS_SHARED_INCLUDE_DIRS osal_shared_impl INCLUDE_DIRECTORIES)

target_include_directories (ut_vxworks_impl_stubs PRIVATE ${OSAL_OS_SHARED_INCLUDE_DIRS})

target_link_libraries (ut_vxworks_impl_stubs PUBLIC ut_osapi_stub_headers)
