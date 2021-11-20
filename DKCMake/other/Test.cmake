message(STATUS "running Test.cmake . . .")
message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
get_filename_component(DKCMAKE "${CMAKE_SOURCE_DIR}/.." ABSOLUTE)
include(${DKCMAKE}/FUNCTIONS.cmake)
message(STATUS "Loaded Functions.cmake\n")



include(C:/Users/Administrator/digitalknob/DK/3rdParty/_DKIMPORTS/far/DKMAKE.cmake)