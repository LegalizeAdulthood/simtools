include(${CMAKE_CURRENT_LIST_DIR}/../../cmake/readline.cmake)

add_executable(flx
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
    target_sources(flx PRIVATE winabsio.c)
else()
    target_sources(flx PRIVATE unxabsio.c)
endif()

target_link_libraries(flx PRIVATE readline)
target_folder(flx "Extractors")
install(TARGETS flx RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/flx.pdf" DESTINATION ${CMAKE_INSTALL_DOCDIR})