include(target_getopt)

add_converter(cosy)
target_getopt(cosy)

if(BUILD_TESTING)
    add_subdirectory(tests)
endif()
