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
target_folder(fsio "Converters")
