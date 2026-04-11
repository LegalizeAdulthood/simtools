find_package(PkgConfig REQUIRED)
pkg_check_modules(readline REQUIRED IMPORTED_TARGET readline)

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
    unxabsio.c
)
target_link_libraries(rstsflx PRIVATE PkgConfig::readline)
target_folder(rstsflx "Extractors")
