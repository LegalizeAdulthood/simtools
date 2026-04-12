add_executable(dbtap
    dbtap.c
    dos11.h dos11.c
    dbtap.txt)
target_link_libraries(dbtap PUBLIC tapeio)
target_getopt(dbtap)
target_folder(dbtap "Extractors")
install(TARGETS dbtap RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/dbtap.txt" DESTINATION ${CMAKE_INSTALL_DOCDIR})
