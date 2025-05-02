function (add_osal_impl_library)

  cmake_parse_arguments (
    _arg # prefix of output variables i.e. arguments will be retrieved as PARSED_ARGS_FOO PARSED_ARGS_BAR
    "" # ; separated list of names of boolean arguments (only defined ones will be true)
    "NAME;" # ; separated list of names of mono-valued arguments
    "BASE_SRCS;IMPL_SRCS;INTERFACE_DEFINITIONS" # ; separated list of names of multi-valued arguments (output
    # variables are lists)
    ${ARGN} # arguments of the function to parse, here we take the all original ones
  )

  # This blocks is if you want to enforce some arguments
  if (NOT ${_args_NAME})
    message (FATAL_ERROR "Missing argument NAME")
  endif ()

  add_library (${_arg_NAME} OBJECT ${_arg_BASE_SRCS} ${_arg_IMPL_SRCS})

  target_include_directories (${_arg_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/inc)

  target_compile_definitions (${_arg_NAME} INTERFACE ${_arg_INTERFACE_DEFINITIONS})

  target_compile_definitions (${_arg_NAME} PRIVATE $<TARGET_PROPERTY:osal_public_api,INTERFACE_COMPILE_DEFINITIONS>)

  target_link_libraries (${_arg_NAME} PRIVATE osal_shared_impl)

  target_compile_options (${_arg_NAME} PRIVATE $<TARGET_PROPERTY:osal_public_api,INTERFACE_COMPILE_OPTIONS>)

  get_filename_component (FOLDER_BASENAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)
  if (NOT ${OSAL_SYSTEM_OSTYPE} STREQUAL ${FOLDER_BASENAME})
    message (STATUS "Excluding ${_arg_NAME} from all (Not part of our mission)s")
    set_target_properties (${_arg_NAME} PROPERTIES EXCLUDE_FROM_ALL True)
  endif ()

endfunction ()
