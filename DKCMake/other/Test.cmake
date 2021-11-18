message(STATUS "running Test.cmake . . .")
message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
get_filename_component(DKCMAKE "${CMAKE_SOURCE_DIR}/.." ABSOLUTE)
include(${DKCMAKE}/FUNCTIONS.cmake)
message(STATUS "Loaded Functions.cmake\n")


message(STATUS "dk_getCurrentDirectory()")
dk_getCurrentDirectory()