if(TARGET readline)
    return()
endif()

find_package(PkgConfig REQUIRED)

# Try pkg-config first (works when readline.pc can resolve its ncurses dependency)
pkg_check_modules(readline QUIET IMPORTED_TARGET readline)

if(TARGET PkgConfig::readline)
    # pkg-config found readline successfully, create an alias
    add_library(readline INTERFACE)
    target_link_libraries(readline INTERFACE PkgConfig::readline)
else()
    # Fallback: readline.pc couldn't find ncurses (vcpkg provides ncursesw, not ncurses)
    # Find curses via pkg-config (ncursesw) or system FindCurses
    pkg_check_modules(ncursesw QUIET IMPORTED_TARGET ncursesw)
    if(NOT TARGET PkgConfig::ncursesw)
        set(CURSES_NEED_NCURSES TRUE)
        find_package(Curses REQUIRED)
    endif()

    find_library(READLINE_LIBRARY NAMES readline REQUIRED)
    find_path(READLINE_INCLUDE_DIR readline/readline.h REQUIRED)

    add_library(readline INTERFACE)
    target_include_directories(readline INTERFACE ${READLINE_INCLUDE_DIR})
    target_link_libraries(readline INTERFACE ${READLINE_LIBRARY})
    if(TARGET PkgConfig::ncursesw)
        target_link_libraries(readline INTERFACE PkgConfig::ncursesw)
    else()
        target_link_libraries(readline INTERFACE ${CURSES_LIBRARIES})
    endif()
endif()
