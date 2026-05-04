add_executable(makehelp ../ods2/makehelp.c ../ods2/compat.c)
target_link_libraries(makehelp PRIVATE Shlwapi)
target_folder(makehelp "Extractors")
