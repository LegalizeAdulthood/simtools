if(NOT WIN32)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(uuid REQUIRED IMPORTED_TARGET uuid)
endif()

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
target_link_libraries(vhd-util-lib PUBLIC libvhd)
if(NOT WIN32)
    target_link_libraries(vhd-util-lib PUBLIC PkgConfig::uuid)
endif()
target_include_directories(vhd-util-lib PUBLIC include)
target_getopt(vhd-util-lib)
target_folder(vhd-util-lib "Extractors")

add_executable(vhd-util vhd-util.c)
target_link_libraries(vhd-util PRIVATE vhd-util-lib)
target_folder(vhd-util "Extractors")
