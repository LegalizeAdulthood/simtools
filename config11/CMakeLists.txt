add_executable(config11
    config11.c
    config11.txt)
install(TARGETS config11 RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
install(FILES config11.txt DESTINATION ${CMAKE_INSTALL_DOCDIR})
