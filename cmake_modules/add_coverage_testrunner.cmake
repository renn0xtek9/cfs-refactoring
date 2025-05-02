# A generic function to add a coverage test case source file This combines the following into an executable - The test
# case setup (a C source file starting with "coveragetest" prefix) - The object code of the unit under test (special
# build with instrumentation) - Links to the stub libraries of everything else, plus UT assert
function (add_coverage_testrunner TESTNAME FSW_SRCFILE TESTCASE_SRCFILE)

  add_library (utobj_${TESTNAME} OBJECT ${FSW_SRCFILE})

  # both the FSW src file and the adaptor file get compiled with override includes
  target_include_directories (
    utobj_${TESTNAME} BEFORE
    PRIVATE
      ${OSALCOVERAGE_SOURCE_DIR}/ut-stubs/override_inc
      $<TARGET_PROPERTY:osal_shared_impl,INTERFACE_INCLUDE_DIRECTORIES>
      $<TARGET_PROPERTY:osal_${SETNAME}_impl,INCLUDE_DIRECTORIES>
      $<TARGET_PROPERTY:ut_osapi_stub_headers,INTERFACE_INCLUDE_DIRECTORIES>)

  target_compile_options (utobj_${TESTNAME} PRIVATE $<TARGET_PROPERTY:ut_coverage_compile,INTERFACE_COMPILE_OPTIONS>)

  target_compile_definitions (utobj_${TESTNAME}
                              PRIVATE $<TARGET_PROPERTY:ut_coverage_compile,INTERFACE_COMPILE_DEFINITIONS>)

  # the testcase is compiled with no special flags or override includes
  add_executable (${TESTNAME}-testrunner ${TESTCASE_SRCFILE} $<TARGET_OBJECTS:utobj_${TESTNAME}>)

  target_link_libraries (${TESTNAME}-testrunner PUBLIC ${ARGN} osal_public_api ut_coverage_link ut_assert)

  add_test (${TESTNAME} ${TESTNAME}-testrunner)

  foreach (TGT ${INSTALL_TARGET_LIST})
    install (TARGETS ${TESTNAME}-testrunner DESTINATION ${TGT}/${UT_INSTALL_SUBDIR})
  endforeach ()

endfunction ()
