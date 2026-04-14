add_test(NAME config11-basic
    COMMAND ${CMAKE_COMMAND}
        -DTEST_PROG=$<TARGET_FILE:config11>
        -DTEST_INPUT=${CMAKE_CURRENT_SOURCE_DIR}/test-input.txt
        -DTEST_EXPECTED=${CMAKE_CURRENT_SOURCE_DIR}/test-expected.txt
        -DTEST_OUTPUT=${CMAKE_CURRENT_BINARY_DIR}/test-output.txt
        -P ${CMAKE_CURRENT_SOURCE_DIR}/run-test.cmake
)
set_tests_properties(config11-basic PROPERTIES LABELS config11)
