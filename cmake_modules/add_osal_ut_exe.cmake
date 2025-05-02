function (add_osal_ut_exe TGTNAME)

  add_executable (${TGTNAME} ${ARGN})
  target_link_libraries (${TGTNAME} PUBLIC ut_assert osal)
  add_test (${TGTNAME} ${TGTNAME})
  foreach (TGT ${INSTALL_TARGET_LIST})
    install (TARGETS ${TGTNAME} DESTINATION ${TGT}/${UT_INSTALL_SUBDIR})
  endforeach ()

endfunction (add_osal_ut_exe)
