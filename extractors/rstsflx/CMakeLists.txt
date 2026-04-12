include(${CMAKE_CURRENT_LIST_DIR}/../../cmake/readline.cmake)

add_executable(rstsflx
    rstsflx.c
    fip.c
    rtime.c
    filename.c
    doget.c
    dolist.c
    doalloc.c
    docomp.c
    dotype.c
    doput.c
    dodump.c
    dodelete.c
    dorename.c
    dorts.c
    doprot.c
    dodir.c
    doident.c
    doinit.c
    dohook.c
    scancmd.c
    doclean.c
    fileio.c
    diskio.c
)

# Platform-specific I/O module
if(WIN32)
    target_sources(rstsflx PRIVATE winabsio.c)
else()
    target_sources(rstsflx PRIVATE unxabsio.c)
endif()

target_link_libraries(rstsflx PRIVATE readline)
target_folder(rstsflx "Extractors")
