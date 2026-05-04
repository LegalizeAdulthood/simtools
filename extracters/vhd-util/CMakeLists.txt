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
target_include_directories(vhd-util-lib PUBLIC include ../libvhd/include)
target_getopt(vhd-util-lib)
target_folder(vhd-util-lib "Extractors")

add_executable(vhd-util vhd-util.c)
target_include_directories(vhd-util PRIVATE include ../libvhd/include)
target_link_libraries(vhd-util PRIVATE vhd-util-lib libvhd)
target_folder(vhd-util "Extractors")
