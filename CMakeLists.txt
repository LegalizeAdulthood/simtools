cmake_minimum_required(VERSION 3.16)

set(CACHE PROJECT_NAME TYPE STRING HELP "Project name for IDEs" VALUE "simh-tools")
project("${PROJECT_NAME}" LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(target_folder)

add_subdirectory(config11)
add_subdirectory(converters)
add_subdirectory(crossassemblers)
add_subdirectory(extractors)
