message(STATUS "running Test.cmake . . .")
message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
message(STATUS "include(${CMAKE_SOURCE_DIR}/../FUNCTIONS.cmake)")
include(DKCMake/FUNCTIONS.cmake)


message(STATUS "dk_getCurrentDirectory()")
dk_getCurrentDirectory()