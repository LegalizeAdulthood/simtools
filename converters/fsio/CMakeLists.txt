include(readline)
include(target_getopt)

add_library(regex INTERFACE)

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
if(WIN32)
    find_package(pcre2 CONFIG REQUIRED)
    target_link_libraries(regex INTERFACE PCRE2::POSIX)
endif()
target_link_libraries(fsio PRIVATE readline regex)
target_getopt(fsio)
target_folder(fsio "Converters")

install(TARGETS fsio RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
install(FILES fsio.txt fsioSimh.txt
    DESTINATION ${CMAKE_INSTALL_DOCDIR})
install(FILES fsio-dos11.1 fsio-dosmt.1 fsio-os8.1 fsio-rt11.1 fsio-unixv7.1 fsio.1
    DESTINATION "${CMAKE_INSTALL_MANDIR}/man1")
