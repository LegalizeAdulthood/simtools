# Test data from
# <https://bitsavers.org/bits/CDC/1700_Cyber18/20100518/MTUP_COSY_1-21-82.tap>
# and rawtap -e used to extract 00001.dat
#
set(test_name "cosy-decompress")
add_test(NAME "${test_name}"
    COMMAND ${CMAKE_COMMAND}
        "-DTEST_DIR=${CMAKE_CURRENT_BINARY_DIR}/${test_name}"
        "-DTEST_PROG=$<TARGET_FILE:cosy>"
        "-DTEST_INPUT=${CMAKE_CURRENT_SOURCE_DIR}/00001.dat"
        "-DTEST_OUTPUT=${CMAKE_CURRENT_SOURCE_DIR}/expected-files.txt"
        "-DTEST_OPTION=d"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/run-test.cmake"
)
set_tests_properties("${test_name}" PROPERTIES LABELS "cosy")
