cmake_minimum_required(VERSION 3.20)

execute_process(
    COMMAND "${TEST_PROG}"
    INPUT_FILE "${TEST_INPUT}"
    OUTPUT_FILE "${TEST_OUTPUT}"
    RESULT_VARIABLE result
)

if(NOT result EQUAL 0)
    message(FATAL_ERROR "${TEST_PROG} failed with exit code: ${result}")
endif()

execute_process(
    COMMAND ${CMAKE_COMMAND} -E compare_files "${TEST_OUTPUT}" "${TEST_EXPECTED}"
    RESULT_VARIABLE compare_result
)

if(NOT compare_result EQUAL 0)
    file(READ "${TEST_OUTPUT}" actual_output)
    file(READ "${TEST_EXPECTED}" expected_output)
    message(FATAL_ERROR
        "Output does not match expected.\n"
        "Expected:\n${expected_output}\n"
        "Actual:\n${actual_output}"
    )
endif()
