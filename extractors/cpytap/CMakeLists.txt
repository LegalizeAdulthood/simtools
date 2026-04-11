add_executable(cpytap cpytap.c tapeio.c)
target_folder(cpytap "Extractors")
target_getopt(cpytap)
