include_guard()

### CMakeLists.txt for DKCMake ###
###
### 	source_path = thisDirectory
###      build_path = AppDirectory/Platform+Architecture/BuildType
###
###
### *** DKCMake ***
### This is the main CMakeLists.txt file for all projects within the code base.
### All Apps, Tools, 3rd party libraries, plugins and executables will be build from here.
### All dependencies will be downloaded, aquired and built for the project as needed. 
### All DKPlugins and DKApp executables will be included into the Generated solution,
### while any 3rd party libraries will be built prior and referenced externally to the project solution.
###
### *** DKBuilder ***
### A text menu based build app called "DKBuilder" exists to simplify the build process for all DK projects.
### And For convienience, there is also a build script provided, build.sh(unix) or build.cmd(windows), that can 
### genrate and build any of the initial apps included in the DKApps directory, including the DKBuilder app itself.
### This is the method that is encourcaged for getting started on generating and compiling DigitalKnob applications.
###
### *** building from the command line **
### DKCmake works a bit differenct than traditional CMake in that this CMakeFile.txt location is always used as the source directory.
### The app, platform and architecture are chosen by where the build directory is set to. For examples: say we want to build an app
### in the DKApps directory called "MyApp" for linux x32_86 Debug.  The cmake source directory will be set here, /Users/username/digitalknob/Development ,
### and the build directy will be set to /Users/username/digitalknob/Development/DKApps/MyApp/linux_x86_64/Debug. The set build directoy tells DKCMake everything 
### it needs to know to begine to process, acuire all dependencies and build the project. 
###
### Example 2:  cmake -G "Visual Studio 17 2022" -A x64 -B C:/Users/username/digitalknob/Development/DKApps/DKBuilder/win_x86_64 -S C:/Users/username/digitalknob/Development
###
### Example 3: 
### 	cd /Users/username/digitalknob/Development/DKApps/DKTestAll/linux_x86_64/Release
###     cmake -G "Unix Makefiles" /Users/username/digitalknob/Development
###
###
### TODO: DKCMake options and variables 
### Build App - just the app (do not delete cmake files, do not do anything with dependencies)
### Rebuild App - the app (erase the app's cmake, and rebuild, but don't do anything with dependencies)
### Build All - (don't erase cmake files, but build the app and it's dependencies)
### Rebeuild All - (erase all cmake files, and build the app and it's dependencies)
###
### Note: The current default setting is RebuildAll except that it does not erase 3rdParty buuilds. It will rebuild all DKPlugins though.
###
### TODO: Add a cmake input variable called "TargetName", allowing us to build a specific Library or Plugin. This should also build 
### all of dependencies for that target. Good for quick testing of specific libraries, plugins or executables.
###
### https://cmake.org/cmake/help/git-master/guide/tutorial/index.html
###

#Load all cmake flags prior to calling PROJECT()
#get_filename_component(DKCMAKE ${CMAKE_SOURCE_DIR} ABSOLUTE)
#include(${DKCMAKE}/DKInit.cmake)


message(STATUS "########################################")
message(STATUS "###### DIGITALKNOB CMakeLists.txt ######")
message(STATUS "########################################")
message(STATUS "\nCMake version ${CMAKE_VERSION}\n")
CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
CMAKE_POLICY(SET CMP0054 NEW)

if(CMAKE_HOST_UNIX)
	execute_process(COMMAND sudo echo WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}) #ask for sudo password ahead of time
endif()

include(${CMAKE_SOURCE_DIR}/functions/dk_dumpAllVariables.cmake)
dk_dumpAllVariables(${CMAKE_BINARY_DIR}/DKCMAKE_START_VARIABLES.temp)



PROJECT(DigitalKnob)
dk_dumpAllVariables(${CMAKE_BINARY_DIR}/DKCMAKE_PROJECT_VARIABLES.temp)



include(${CMAKE_SOURCE_DIR}/DKGenerate.cmake)
dk_dumpAllVariables(${CMAKE_BINARY_DIR}/DKCMAKE_END_VARIABLES.temp)

