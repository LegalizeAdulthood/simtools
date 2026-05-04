set(ODS2_SOURCES
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
    list(APPEND ODS2_SOURCES phynt.c)
else()
    list(APPEND ODS2_SOURCES phyunix.c)
endif()

add_executable(ods2 ${ODS2_SOURCES})
target_link_libraries(ods2 PRIVATE Shlwapi)
target_folder(ods2 "Extractors")
