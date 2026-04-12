if(TARGET uuid)
    return()
endif()

add_library(uuid INTERFACE)
if(NOT WIN32)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(uuid REQUIRED IMPORTED_TARGET uuid)
    # Use uuid_INCLUDEDIR (not uuid_INCLUDE_DIRS) to work around vcpkg's
    # incorrect Cflags which appends /uuid to the include path
    target_include_directories(uuid INTERFACE ${uuid_INCLUDEDIR})
    target_link_libraries(uuid INTERFACE PkgConfig::uuid)
endif()
