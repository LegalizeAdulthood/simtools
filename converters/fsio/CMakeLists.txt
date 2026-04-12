find_package(PkgConfig REQUIRED)

# vcpkg provides ncursesw, but readline's .pc file depends on ncurses
# Use CMake's FindCurses which handles this properly
set(CURSES_NEED_NCURSES TRUE)
find_package(Curses REQUIRED)

# Try pkg-config first (works on Linux with system readline)
pkg_check_modules(readline QUIET IMPORTED_TARGET readline)

if(NOT TARGET PkgConfig::readline)
    # Fallback for macOS/vcpkg where readline.pc can't find ncurses
    find_library(READLINE_LIBRARY NAMES readline REQUIRED)
    find_path(READLINE_INCLUDE_DIR readline/readline.h REQUIRED)

    add_library(PkgConfig::readline UNKNOWN IMPORTED)
    set_target_properties(PkgConfig::readline PROPERTIES
        IMPORTED_LOCATION "${READLINE_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${READLINE_INCLUDE_DIR}"
        INTERFACE_LINK_LIBRARIES "${CURSES_LIBRARIES}"
    )
endif()

# Changes
# CMakeLists.txt
# declib.c
# declib.h
# dos11.c
# dos11.h
# dosmt.c
# dosmt.h
# fsio-dos11.1
# fsio-dosmt.1
# fsio-os8.1
# fsio-rt11.1
# fsio.1
# fsio.c
# fsio.h
# fsio.txt
# fsioSimh.txt
# local.c
# Makefile
# os8.c
# os8.h
# rt11.c
# rt11.h
# tape.c
# tape.h
add_executable(fsio
    fsio.h fsio.c
    declib.h declib.c
    tape.h tape.c
    dos11.h dos11.c
    rt11.h rt11.c
    dosmt.h dosmt.c
    local.c
    os8.h os8.c
    unixv7.h unixv7.c
)
target_link_libraries(fsio PRIVATE PkgConfig::readline)
target_folder(fsio "Converters")
