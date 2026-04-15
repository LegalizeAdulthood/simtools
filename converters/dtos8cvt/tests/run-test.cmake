cmake_minimum_required(VERSION 3.20)

file(REMOVE_RECURSE "${TEST_DIR}")
file(MAKE_DIRECTORY "${TEST_DIR}")
file(COPY_FILE "${TEST_INPUT}" "${TEST_DIR}/test.tu56")

execute_process(
    COMMAND "${TEST_PROG}" "test.tu56"
    WORKING_DIRECTORY "${TEST_DIR}"
    RESULT_VARIABLE result
)

if(NOT result EQUAL 0)
    message(FATAL_ERROR "${TEST_PROG} failed with exit code: ${result}")
endif()

file(MD5 "${TEST_DIR}/test.dt8" ACTUAL_HASH)
if(NOT "${ACTUAL_HASH}" STREQUAL "${TEST_OUTPUT_HASH}")
    message(FATAL_ERROR "Expected hash ${TEST_OUTPUT_HASH}, got ${ACTUAL_HASH}")
endif()
