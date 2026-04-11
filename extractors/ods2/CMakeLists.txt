add_executable(makehelp makehelp.c compat.c)
if(WIN32)
    target_link_libraries(makehelp PRIVATE Shlwapi)
endif()
target_folder(makehelp "Extractors")

add_executable(ods2
    ods2.c
    access.c
    cache.c
    compat.c
    copycmd.c
    createcmd.c
    debug.c
    deletecmd.c
    device.c
    diffcmd.c
    dircmd.c
    direct.c
    dismountcmd.c
    extendcmd.c
    helpcmd.c
    initialcmd.c
    initvol.c
    mountcmd.c
    phyvirt.c
    renamecmd.c
    rms.c
    searchcmd.c
    setcmd.c
    showcmd.c
    spawncmd.c
    sysmsg.c
    termio.c
    update.c
    vmstime.c
)
if(WIN32)
    target_sources(ods2 PRIVATE phynt.c)
    target_link_libraries(ods2 PRIVATE Shlwapi)
else()
    target_sources(ods2 PRIVATE phyunix.c)
endif()
target_folder(ods2 "Extractors")
