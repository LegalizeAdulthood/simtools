# Test data from
# <https://www.pdp8online.com/ftp/images/misc_dectapes/AL-4711C-BA.tu56>
#
set(test_name "dtos8cvt")

add_test(NAME "${test_name}"
    COMMAND ${CMAKE_COMMAND}
        "-DTEST_DIR=${CMAKE_CURRENT_BINARY_DIR}/${test_name}"
        "-DTEST_PROG=$<TARGET_FILE:dtos8cvt>"
        "-DTEST_INPUT=${CMAKE_CURRENT_SOURCE_DIR}/AL-4711C-BA.tu56"
        "-DTEST_OUTPUT_HASH=78a7c3cb69ae638f2d076d6e804f8747"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/run-test.cmake"
)
set_tests_properties("${test_name}" PROPERTIES LABELS "dtos8cvt")
