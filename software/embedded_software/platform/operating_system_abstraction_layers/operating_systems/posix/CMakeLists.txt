# ######################################################################################################################
#
# CMAKE build recipe for POSIX OSAL implementation
#
# ######################################################################################################################

# This CMake script generates targets specific to the POSIX implementation

# The basic set of files which are always built
set (
  POSIX_BASE_SRCLIST
  src/os-impl-binsem.c
  src/os-impl-common.c
  src/os-impl-console.c
  src/os-impl-condvar.c
  src/os-impl-countsem.c
  src/os-impl-dirs.c
  src/os-impl-errors.c
  src/os-impl-files.c
  src/os-impl-filesys.c
  src/os-impl-heap.c
  src/os-impl-idmap.c
  src/os-impl-mutex.c
  src/os-impl-queues.c
  src/os-impl-tasks.c
  src/os-impl-timebase.c)

# Use portable blocks for basic I/O
set (
  POSIX_IMPL_SRCLIST
  ../portable/os-impl-posix-gettime.c ../portable/os-impl-console-bsp.c ../portable/os-impl-bsd-select.c
  ../portable/os-impl-posix-io.c ../portable/os-impl-posix-files.c ../portable/os-impl-posix-dirs.c)

if (OSAL_CONFIG_INCLUDE_SHELL)
  list (APPEND POSIX_IMPL_SRCLIST src/os-impl-shell.c)
else ()
  list (APPEND POSIX_IMPL_SRCLIST ../portable/os-impl-no-shell.c)
endif ()

# If some form of module loading is configured, then build the module loader
if (OSAL_CONFIG_INCLUDE_DYNAMIC_LOADER)
  list (APPEND POSIX_IMPL_SRCLIST src/os-impl-loader.c ../portable/os-impl-posix-dl-loader.c
        ../portable/os-impl-posix-dl-symtab.c)
else ()
  list (APPEND POSIX_IMPL_SRCLIST src/os-impl-no-module.c ../portable/os-impl-no-loader.c
        ../portable/os-impl-no-symtab.c)
endif ()

if (OSAL_CONFIG_INCLUDE_NETWORK)
  list (
    APPEND POSIX_IMPL_SRCLIST ../portable/os-impl-bsd-sockets.c # Use BSD socket layer implementation
    ../portable/os-impl-posix-network.c # Use POSIX-defined hostname/id implementation
  )
else ()
  list (
    APPEND POSIX_IMPL_SRCLIST ../portable/os-impl-no-network.c # non-implemented versions of all network APIs
    ../portable/os-impl-no-sockets.c # non-implemented versions of all socket APIs
  )
endif ()

add_osal_impl_library (
  NAME
  osal_posix_impl
  BASE_SRCS
  ${POSIX_BASE_SRCLIST}
  IMPL_SRCS
  ${POSIX_IMPL_SRCLIST}
  INTERFACE_DEFINITIONS
  _POSIX_OS_)
