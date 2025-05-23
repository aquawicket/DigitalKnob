CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${CMAKE_SOURCE_DIR}/functions/")
endif()
set(ENV{DKSCRIPT_PATH} "${CMAKE_SOURCE_DIR}/CMakeLists.txt")
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

### CMakeLists.txt for DKCMake ###
###
###		source_path = thisDirectory
###		build_path = AppDirectory/Platform+Architecture/BuildType
###
### *** DKCMake ***
### This is the main CMakeLists.txt file for all projects within the code base.
### All Apps, Tools, 3rd party libraries, plugins and executables will be build from here.
### All dependencies will be downloaded, aquired and built for the project as needed. 
### All DKCpp/plugins and DKApp executables will be included into the Generated solution,
### while any 3rd party libraries will be built prior and referenced externally to the project solution.
###
### *** DKBuilder ***
### A text menu based build app called "DKBuilder" exists to simplify the build process for all DK projects.
### And For convienience, there is also a build script provided, build.sh(unix) or build.cmd(windows), that can 
### genrate and build any of the initial apps included in the DKCpp/apps directory, including the DKBuilder app itself.
### This is the method that is encourcaged for getting started on generating and compiling DigitalKnob applications.
###
### *** building from the command line **
### DKCmake works a bit differenct than traditional CMake in that this CMakeFile.txt location is always used as the source directory.
### The app, platform and architecture are chosen by where the build directory is set to. For examples: say we want to build an app
### in the DKCpp/apps directory called "MyApp" for linux x32_86 Debug.  The cmake source directory will be set here, /Users/username/digitalknob/Development ,
### and the build directy will be set to /Users/username/digitalknob/Development/DKCpp/apps/MyApp/linux_x86_64/Debug. The set build directoy tells DKCMake everything 
### it needs to know to begine to process, acuire all dependencies and build the project. 
###
### Example 2:  cmake -G "Visual Studio 17 2022" -A x64 -B C:/Users/username/digitalknob/Development/DKCpp/apps/DKBuilder/win_x86_64 -S C:/Users/username/digitalknob/Development
###
### Example 3: 
###		cd /Users/username/digitalknob/Development/DKCpp/apps/DKTestAll/linux_x86_64/Release
###		cmake -G "Unix Makefiles" /Users/username/digitalknob/Development
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
message("##############################################################")
message("################# DigitalKnob CMakeLists.txt #################")
message("##############################################################")


dk_load(dk_dumpAllVariables)
		dk_dumpAllVariables("${CMAKE_BINARY_DIR}/DKCMAKE_START_VARIABLES.temp")

#Load all cmake flags prior to calling PROJECT()
dk_load("$ENV{DKCMAKE_DIR}/DKVariables.cmake")
dk_load("$ENV{DKCMAKE_DIR}/DKBuildFlags.cmake")
		dk_dumpAllVariables("${CMAKE_BINARY_DIR}/DKCMAKE_FLAG_VARIABLES.temp")

message("################# PROJECT(DigitalKnob) #################")
PROJECT(DigitalKnob)
		dk_dumpAllVariables("${CMAKE_BINARY_DIR}/DKCMAKE_PROJECT_VARIABLES.temp")

dk_load("$ENV{DKCMAKE_DIR}/DKGenerate.cmake")
		dk_dumpAllVariables("${CMAKE_BINARY_DIR}/DKCMAKE_END_VARIABLES.temp")
