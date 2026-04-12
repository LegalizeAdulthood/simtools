
# Test cases for macro11
set(MACRO11_TESTS
    test-asciz
    test-backpatch
    test-blkb
    test-bsl-mac-arg
    test-cis
    test-complex-reloc
    test-enabl-ama
    test-enabl-lcm
    test-endm
    test-float
    test-gbl
    test-if
    test-impword
    test-include
    test-jmp
    test-listing
    test-locals
    test-macro-comma
    test-mcall-file
    test-opcodes
    test-operands
    test-prec
    test-psect
    test-rad50
    test-radix
    test-reg
    test-reloc
    test-rept
    test-syntax
    test-ua-pl
    test-undef
    test-word-comma
)

set(MACRO11_TEST_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(MACRO11_TEST_SCRIPT "${MACRO11_TEST_DIR}/run-test.cmake")

foreach(TEST_NAME IN LISTS MACRO11_TESTS)
    foreach(TEST_FORMAT IN ITEMS "-rsx" "-rt11")
        string(REPLACE "-" "" FORMAT_SUFFIX "${TEST_FORMAT}")
        add_test(
            NAME "macro11-${TEST_NAME}-${FORMAT_SUFFIX}"
            COMMAND "${CMAKE_COMMAND}"
                -DTEST_NAME=${TEST_NAME}
                -DTEST_FORMAT=${TEST_FORMAT}
                -DMACRO11=$<TARGET_FILE:macro11>
                -DDUMPOBJ=$<TARGET_FILE:dumpobj>
                -DTEST_DIR=${MACRO11_TEST_DIR}
                -P "${MACRO11_TEST_SCRIPT}"
        )
    endforeach()
endforeach()

# 2.11BSD m11 tests
file(GLOB M11_FILES "${CMAKE_CURRENT_SOURCE_DIR}/2.11BSD/m11/*.m11")

foreach(M11_FILE IN LISTS M11_FILES)
    # Get relative path from test directory (e.g., "2.11BSD/m11/foo.m11")
    file(RELATIVE_PATH M11_FILE_REL "${CMAKE_CURRENT_SOURCE_DIR}" "${M11_FILE}")

    # Create test name by replacing / with - and removing .m11 extension
    # e.g., "2.11BSD/m11/foo.m11" -> "2.11BSD-m11-foo"
    string(REGEX REPLACE "\\.m11$" "" TEST_NAME "${M11_FILE_REL}")
    string(REPLACE "/" "-" TEST_NAME "${TEST_NAME}")

    # Generate the wrapper .mac file using configure_file
    set(WRAPPER_MAC "${CMAKE_CURRENT_SOURCE_DIR}/${TEST_NAME}.mac")
    configure_file("test.mac.in" "${WRAPPER_MAC}" @ONLY)

    # Add tests for both formats
    foreach(TEST_FORMAT IN ITEMS "-rsx" "-rt11")
        string(REPLACE "-" "" FORMAT_SUFFIX "${TEST_FORMAT}")
        add_test(
            NAME "macro11-${TEST_NAME}-${FORMAT_SUFFIX}"
            COMMAND "${CMAKE_COMMAND}"
                -DTEST_NAME=${TEST_NAME}
                -DTEST_FORMAT=${TEST_FORMAT}
                -DMACRO11=$<TARGET_FILE:macro11>
                -DDUMPOBJ=$<TARGET_FILE:dumpobj>
                -DTEST_DIR=${CMAKE_CURRENT_BINARY_DIR}
                -P "${MACRO11_TEST_SCRIPT}"
        )
    endforeach()
endforeach()
