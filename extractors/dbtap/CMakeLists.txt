add_executable(dbtap dbtap.c tapeio.c dos11.c)
target_folder(dbtap "Extractors")
target_getopt(dbtap)
