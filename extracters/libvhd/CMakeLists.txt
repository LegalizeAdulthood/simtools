add_library(libvhd STATIC libvhd.c relative-path.c)
target_include_directories(libvhd PUBLIC include)
target_folder(libvhd "Extractors")
