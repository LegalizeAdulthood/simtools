include(uuid)

add_library(vhd-util-lib STATIC 
    include/atomicio.h
    include/libvhd-journal.h
    include/list.h
    include/lvm-util.h
    include/vhd-util-win32.h
    include/vhd-util.h
    include/wingetopt.h
    atomicio.c
    libvhd-journal.c
    vhd-util-check.c
    vhd-util-coalesce.c
    vhd-util-create.c
    vhd-util-fill.c
    lvm-util.c
    vhd-util-modify.c
    vhd-util-query.c
    vhd-util-read.c
    vhd-util-repair.c
    vhd-util-resize.c
    vhd-util-revert.c
    vhd-util-scan.c
    vhd-util-set-field.c
    vhd-util-snapshot.c
)
target_link_libraries(vhd-util-lib PUBLIC libvhd uuid)
target_include_directories(vhd-util-lib PUBLIC include)
target_getopt(vhd-util-lib)
target_folder(vhd-util-lib "Extractors")

add_executable(vhd-util vhd-util.c)
target_link_libraries(vhd-util PRIVATE vhd-util-lib)
target_install(vhd-util)
target_folder(vhd-util "Extractors")

install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/README"
    DESTINATION ${CMAKE_INSTALL_DOCDIR}
    RENAME "vhd-util.txt")
