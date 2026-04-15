cmake_minimum_required(VERSION 3.20)

execute_process(
    COMMAND "${TEST_PROG}" "-${TEST_OPTION}" "${TEST_INPUT}"
    RESULT_VARIABLE result
)

if(NOT result EQUAL 0)
    message(FATAL_ERROR "${TEST_PROG} failed with exit code: ${result}")
endif()

file(MD5 "${TEST_OUTPUT}" ACTUAL_HASH)
if(NOT "${EXPECTED_HASH}" STREQUAL "${ACTUAL_HASH}")
    message(FATAL_ERROR "Expected hash ${EXPECTED_HASH}, got ${ACTUAL_HASH}")
endif()
