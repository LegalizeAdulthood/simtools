cmake_minimum_required(VERSION 3.20)

file(REMOVE_RECURSE "${TEST_DIR}")
file(MAKE_DIRECTORY "${TEST_DIR}")

execute_process(
    COMMAND "${TEST_PROG}" "-${TEST_OPTION}" "${TEST_INPUT}"
    WORKING_DIRECTORY "${TEST_DIR}"
    RESULT_VARIABLE result
)

if(NOT result EQUAL 0)
    message(FATAL_ERROR "${TEST_PROG} failed with exit code: ${result}")
endif()

file(GLOB ACTUAL_PATHS "${TEST_DIR}/*")
set(ACTUAL_FILES)
foreach(path IN LISTS ACTUAL_PATHS)
    get_filename_component(path "${path}" NAME)
    list(APPEND ACTUAL_FILES "${path}")
endforeach()
list(SORT ACTUAL_FILES)

file(STRINGS "${TEST_OUTPUT}" EXPECTED_FILES)

if(NOT "${ACTUAL_FILES}" STREQUAL "${EXPECTED_FILES}")
    message(FATAL_ERROR "Expected files ${EXPECTED_FILES}, got ${ACTUAL_FILES}")
endif()
