function(target_getopt name)
    if(NOT TARGET getopt)
        add_library(getopt INTERFACE)
        if(WIN32)
            find_package(getopt CONFIG REQUIRED)

            target_link_libraries(getopt INTERFACE
                $<IF:$<TARGET_EXISTS:getopt::getopt_shared>,getopt::getopt_shared,getopt::getopt_static>)
        endif()
    endif()
    target_link_libraries("${name}" PUBLIC getopt)
endfunction()
