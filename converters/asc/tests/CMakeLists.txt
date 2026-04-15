function(add_asc_test name option hash)
    set(test_name "asc-${name}")
    add_test(NAME "${test_name}"
        COMMAND ${CMAKE_COMMAND}
            -DTEST_PROG=$<TARGET_FILE:asc>
            -DTEST_INPUT=${CMAKE_CURRENT_SOURCE_DIR}/test.txt
            -DTEST_OUTPUT=${CMAKE_CURRENT_SOURCE_DIR}/test.new
            -DTEST_OPTION=${option}
            -DEXPECTED_HASH=${hash}
            -P ${CMAKE_CURRENT_SOURCE_DIR}/run-test.cmake
    )
    set_tests_properties("${test_name}" PROPERTIES LABELS "asc")
endfunction()

add_asc_test("mac"     "m" "63a3c6a4692d39abc143ce146a508086")
add_asc_test("unix"    "u" "39109fdba785dec1c8e90afb688e79a3")
add_asc_test("windows" "w" "c0fb0787e5d6b042b61cac0b10dbe48d")
