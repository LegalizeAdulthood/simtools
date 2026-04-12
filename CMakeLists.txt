cmake_minimum_required(VERSION 3.16)

set(CACHE PROJECT_NAME TYPE STRING HELP "Project name for IDEs" VALUE "simh-tools")
project("${PROJECT_NAME}" VERSION 1.0.0 LANGUAGES C)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Installation directory" FORCE)
endif()

# This is because we might have PROJECT_NAME set to something for the IDE
# but it will be used to construct this directory name in GNUInstallDirs.
set(CMAKE_INSTALL_DOCDIR "share/doc/simh-tools" CACHE PATH "Documentation directory")
include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(target_folder)

include(CTest)

add_subdirectory(config11)
add_subdirectory(converters)
add_subdirectory(crossassemblers)
add_subdirectory(extractors)

install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/README.md"
    DESTINATION ${CMAKE_INSTALL_DOCDIR} RENAME "simh-tools.md")

# CPack packaging configuration
set(CPACK_PACKAGE_NAME "simh-tools")
if(WIN32)
    set(CPACK_GENERATOR "ZIP")
else()
    set(CPACK_GENERATOR "TGZ")
endif()
include(CPack)
