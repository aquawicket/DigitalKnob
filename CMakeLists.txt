### MASTER CMakeLists.txt FILE ###
###
### This will be the ONLY CMakeLists.txt file in DigitalKnob
### All Apps will be build from here.
### The required Tools, libraries and plugins will optionaly build from here. 
###
### TODO
### Build App - just the app (do not delete cmake files, do not do anything with dependencies)
### Rebuild App - the app (erase the app's cmake, and rebuild, but don't do anything with dependencies)
### Build All - (don't erase cmake files, but build the app and it's dependencies)
### Rebeuild All - (erase all cmake files, and build the app and it's dependencies)
if(CMAKE_HOST_UNIX)
	execute_process(COMMAND sudo echo WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}) #ask for sudo password ahead of time
endif()

CMAKE_MINIMUM_REQUIRED(VERSION 3.4)
CMAKE_POLICY(SET CMP0054 NEW)
PROJECT(DigitalKnob)
INCLUDE(DKCMake/PROCESS.cmake)