cmake_minimum_required(VERSION 3.16)

set(CACHE PROJECT_NAME TYPE STRING HELP "Project name for IDEs" VALUE "simh-tools")
project("${PROJECT_NAME}" LANGUAGES C)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Installation directory" FORCE)
endif()

# This is because we might have PROJECT_NAME set to something for the IDE
# but it will be used to construct this directory name in GNUInstallDirs.
set(CMAKE_INSTALL_DOCDIR "share/doc/simh-tools" CACHE PATH "Documentation directory")
include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(target_folder)

add_subdirectory(config11)
add_subdirectory(converters)
add_subdirectory(crossassemblers)
add_subdirectory(extractors)
