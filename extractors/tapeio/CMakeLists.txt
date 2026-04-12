add_library(tapeio STATIC
    defs.h
    tapeio.h tapeio.c
    tap.h)
target_include_directories(tapeio PUBLIC .)
target_folder(tapeio "Extractors")
