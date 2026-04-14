# Generate git-info.h with version information
find_package(Git QUIET)
if(GIT_FOUND)
    execute_process(
        COMMAND "${GIT_EXECUTABLE}" describe --tags
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        OUTPUT_VARIABLE GIT_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
        RESULT_VARIABLE GIT_DESCRIBE_RESULT
    )
    if(GIT_DESCRIBE_RESULT EQUAL 0 AND NOT GIT_VERSION STREQUAL "")
        execute_process(
            COMMAND "${GIT_EXECUTABLE}" log -n 1 "--pretty=format:%an <%ae> %aD"
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
            OUTPUT_VARIABLE GIT_AUTHOR_DATE
            OUTPUT_STRIP_TRAILING_WHITESPACE
            ERROR_QUIET
        )
    else()
        unset(GIT_VERSION)
        unset(GIT_AUTHOR_DATE)
    endif()
else()
    unset(GIT_VERSION)
    unset(GIT_AUTHOR_DATE)
endif()

configure_file("git-info.h.in" "git-info.h" @ONLY)

add_executable(macro11
    "macro11.c" "macro11.h"
    "assemble.c" "assemble.h"
    "assemble_globals.c" "assemble_globals.h"
    "assemble_aux.c" "assemble_aux.h"
    "extree.c" "extree.h"
    "listing.c" "listing.h"
    "macros.c" "macros.h"
    "parse.c" "parse.h"
    "rept_irpc.c" "rept_irpc.h"
    "symbols.c" "symbols.h"
    "mlb2.c" "mlb.h"
    "mlb-rsx.c"
    "mlb-rt11.c"
    "object.c" "object.h"
    "stream2.c" "stream2.h"
    "util.c" "util.h"
    "rad50.c" "rad50.h"
    "git-info.h.in"
    "${CMAKE_CURRENT_BINARY_DIR}/git-info.h"
)
target_include_directories(macro11 PRIVATE "${CMAKE_CURRENT_BINARY_DIR}")
target_folder(macro11 "Cross Assemblers")
target_install(macro11)
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/README" DESTINATION ${CMAKE_INSTALL_DOCDIR} RENAME "macro11.txt")

add_executable(dumpobj
    "dumpobj.c"
    "rad50.c" "rad50.h"
    "util.h"
)
target_folder(dumpobj "Cross Assemblers")
target_install(dumpobj)

add_subdirectory(obj2bin)

if(BUILD_TESTING)
    add_subdirectory(tests)
endif()
