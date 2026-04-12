include(uuid)

add_library(libvhd STATIC
    "include/blk_uuid.h"
    "include/vhd.h" 
    "include/libvhd.h" libvhd.c
    "include/relative-path.h" relative-path.c
)
target_include_directories(libvhd PUBLIC include)
target_link_libraries(libvhd PUBLIC uuid)
if(NOT WIN32)
    find_package(Iconv REQUIRED)
    target_link_libraries(libvhd PUBLIC Iconv::Iconv)
endif()
target_folder(libvhd "Extractors")
