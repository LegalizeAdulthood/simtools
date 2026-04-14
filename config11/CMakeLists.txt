add_executable(config11
    config11.c
    config11.txt)
target_install(config11)
install(FILES config11.txt DESTINATION ${CMAKE_INSTALL_DOCDIR})
