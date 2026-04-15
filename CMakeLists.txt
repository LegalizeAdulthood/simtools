cmake_minimum_required(VERSION 3.21)

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
include(target_install)

include(CTest)

add_subdirectory(config11)
add_subdirectory(converters)
add_subdirectory(crossassemblers)
add_subdirectory(extractors)

install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/README.md"
    DESTINATION ${CMAKE_INSTALL_DOCDIR} RENAME "simh-tools.md")

# CPack packaging configuration
set(CPACK_PACKAGE_NAME "simh-tools")
# Map the values of CMAKE_SYSTEM_PROCESSOR to our preferred value.
set(TRANSLATE_PROCESSOR_AMD64 "x86_64")
set(TRANSLATE_PROCESSOR_ARM64 "arm64")
set(TRANSLATE_PROCESSOR_aarch64 "arm64")
set(SYSTEM_PROCESSOR "${TRANSLATE_PROCESSOR_${CMAKE_SYSTEM_PROCESSOR}}")
if("${SYSTEM_PROCESSOR}" STREQUAL "")
    set(SYSTEM_PROCESSOR "${CMAKE_SYSTEM_PROCESSOR}")
endif()
# map the system name to our preferred value; do ordinary users know what "Darwin" means?
set(TRANSLATE_SYSTEM_Darwin "macOS")
set(SYSTEM_NAME "${TRANSLATE_SYSTEM_${CMAKE_SYSTEM_NAME}}")
if("${SYSTEM_NAME}" STREQUAL "")
    set(SYSTEM_NAME "${CMAKE_SYSTEM_NAME}")
endif()
# simh-tools-1.0.0-Linux-x86_64.tar.gz
set(CPACK_PACKAGE_FILE_NAME
    "${CPACK_PACKAGE_NAME}-${PROJECT_VERSION}-${SYSTEM_NAME}-${SYSTEM_PROCESSOR}")
if(WIN32)
    set(CPACK_GENERATOR "ZIP")
else()
    set(CPACK_GENERATOR "TGZ")
endif()
include(CPack)
