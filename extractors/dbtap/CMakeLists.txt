add_executable(dbtap
    dbtap.c
    dos11.h dos11.c)
target_link_libraries(dbtap PUBLIC tapeio)
target_getopt(dbtap)
target_folder(dbtap "Extractors")
