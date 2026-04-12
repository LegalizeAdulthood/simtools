# CMake script to run a single macro11 test case.
#
# Required variables:
#   TEST_NAME   - Name of the test (e.g., "test-asciz")
#   TEST_FORMAT - Object format: "-rsx" or "-rt11"
#   MACRO11     - Path to the macro11 executable
#   DUMPOBJ     - Path to the dumpobj executable
#   TEST_DIR    - Path to the tests directory (where .mac files are)
#
# The script assembles TEST_NAME.mac and compares outputs against
# expected files (.lst.ok, .objd.ok) if they exist.

cmake_minimum_required(VERSION 3.10)

# Validate required variables
if(NOT DEFINED TEST_NAME)
    message(FATAL_ERROR "TEST_NAME is not defined")
endif()
if(NOT DEFINED TEST_FORMAT)
    message(FATAL_ERROR "TEST_FORMAT is not defined")
endif()
if(NOT DEFINED MACRO11)
    message(FATAL_ERROR "MACRO11 is not defined")
endif()
if(NOT DEFINED DUMPOBJ)
    message(FATAL_ERROR "DUMPOBJ is not defined")
endif()
if(NOT DEFINED TEST_DIR)
    message(FATAL_ERROR "TEST_DIR is not defined")
endif()

set(TEST_MAC "${TEST_NAME}.mac")
set(TEST_LST "${TEST_DIR}/${TEST_NAME}.lst")
set(TEST_OBJ "${TEST_DIR}/${TEST_NAME}.obj")
set(TEST_OBJD "${TEST_DIR}/${TEST_NAME}.objd")
set(TEST_LST_OK "${TEST_DIR}/${TEST_NAME}.lst.ok")
set(TEST_OBJD_OK "${TEST_DIR}/${TEST_NAME}.objd.ok")

# Run the assembler
execute_process(
    COMMAND "${MACRO11}" ${TEST_FORMAT} -l "${TEST_LST}" -o "${TEST_OBJ}" "${TEST_MAC}"
    WORKING_DIRECTORY "${TEST_DIR}"
    RESULT_VARIABLE MACRO11_RESULT
    ERROR_QUIET
)
# Ignore assembler error status - we check the listing file for expected results

set(TEST_FAILED FALSE)

# Compare listing file if expected file exists
if(EXISTS "${TEST_LST_OK}")
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E compare_files "${TEST_LST_OK}" "${TEST_LST}"
        RESULT_VARIABLE LST_DIFF_RESULT
    )
    if(NOT LST_DIFF_RESULT EQUAL 0)
        message(STATUS "Listing file differs from expected:")
        execute_process(
            COMMAND "${CMAKE_COMMAND}" -E cat "${TEST_LST}"
        )
        message(FATAL_ERROR "Test ${TEST_NAME} (${TEST_FORMAT}): Listing file mismatch")
    endif()
endif()

# Compare object dump if expected file exists
if(EXISTS "${TEST_OBJD_OK}")
    # Run dumpobj to create the object dump
    execute_process(
        COMMAND "${DUMPOBJ}" ${TEST_FORMAT} "${TEST_OBJ}"
        WORKING_DIRECTORY "${TEST_DIR}"
        OUTPUT_FILE "${TEST_OBJD}"
        RESULT_VARIABLE DUMPOBJ_RESULT
    )
    if(NOT DUMPOBJ_RESULT EQUAL 0)
        message(FATAL_ERROR "Test ${TEST_NAME} (${TEST_FORMAT}): dumpobj failed")
    endif()

    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E compare_files "${TEST_OBJD_OK}" "${TEST_OBJD}"
        RESULT_VARIABLE OBJD_DIFF_RESULT
    )
    if(NOT OBJD_DIFF_RESULT EQUAL 0)
        message(STATUS "Object dump differs from expected:")
        execute_process(
            COMMAND "${CMAKE_COMMAND}" -E cat "${TEST_OBJD}"
        )
        message(FATAL_ERROR "Test ${TEST_NAME} (${TEST_FORMAT}): Object dump mismatch")
    endif()
endif()

message(STATUS "Test ${TEST_NAME} (${TEST_FORMAT}): PASSED")
