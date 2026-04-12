include(uuid)

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

# Platform-specific configuration
if(WIN32)
    # Windows NT configuration
    target_sources(ods2 PRIVATE
        phynt.c
        phyvhd.c
        winfile.h winfile.c
        vhd/libvhd.c
        vhd/relative-path.c
    )
    target_compile_definitions(ods2 PRIVATE
        USE_VHD
        LIBVHD_HAS_SYSLOG=0
    )
    target_include_directories(ods2 PRIVATE vhd)
    target_link_libraries(ods2 PRIVATE Shlwapi Rpcrt4)
elseif(VMS)
    # OpenVMS configuration
    target_sources(ods2 PRIVATE phyvms.c)
else()
    # Unix configuration (Linux, macOS, Solaris, Tru64, etc.)
    target_sources(ods2 PRIVATE
        phyunix.c
        phyvhd.c
        vhd/libvhd.c
        vhd/relative-path.c
    )
    target_compile_definitions(ods2 PRIVATE
        _FILE_OFFSET_BITS=64
        _GNU_SOURCE
        USE_VHD
        LIBVHD_HAS_SYSLOG=0
    )
    target_include_directories(ods2 PRIVATE vhd)

    target_link_libraries(ods2 PRIVATE uuid)

    # Optional: libedit support for command line editing
    find_library(EDIT_LIBRARY edit)
    find_library(TERMCAP_LIBRARY termcap)
    if(EDIT_LIBRARY AND TERMCAP_LIBRARY)
        target_compile_definitions(ods2 PRIVATE USE_LIBEDIT)
        target_link_libraries(ods2 PRIVATE ${EDIT_LIBRARY} ${TERMCAP_LIBRARY})
    endif()
endif()

target_folder(ods2 "Extractors")
