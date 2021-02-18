# This file is for testing new code, debugging etc.
MESSAGE(STATUS "Running Scratchpad.cmake   Happy debugging :)")
################################################################


##We need something that can evaulate the value of a DKVariable.
##It needs to be callable from command-line and return data
##Syntax:  var VALUE = GetDKCMakeVariable(VARNAME, OS, ARCH);

##We need to be able to call this from the command line if not active CMake environment is runnning.
##This needs to scan DigitalKnobs DKCMake files for the NDK variable and return the computed value;
##EXAMPLE: var NDK = GetDKCMakeVariable("ANDROID_NDK", "WINDOWS", "x64");


##Here are some of our options

##cmake env [--unset=NAME]... [NAME=VALUE]... COMMAND [ARG]...
##Run command in a modified environment.

##cmake [{-D <var>=<value>}...] -P <cmake-script-file> [-- <unparsed-options>...]
##Process the given cmake file as a script written in the CMake language. No configure or generate step is performed and the cache is not modified. If variables are ##defined using -D, this must be done before the -P argument.
##Any options after -- are not parsed by CMake, but they are still included in the set of CMAKE_ARGV<n> variables passed to the script (including the -- itself).

##command line
##cmake -P C:\digitalknob\DK\DKCMake\scratchpad.cmake


INCLUDE(C:/digitalknob/DK/DKCMake/FUNCTIONS.cmake)
DKSET(OS "win32")
DKSET(DKPROJECT "0")
DKSET(RELEASE "ON")
DKSET(BUILD "ON")
INCLUDE(C:/digitalknob/DK/DKCMake/OPTIONS.cmake)
INCLUDE(C:/digitalknob/DK/DKPlugins/DK/DKCMake.txt)
MESSAGE(STATUS "${TEST_VAR}")

## On second thought, this isn't a good idea. If im just trying to pick the latest version of a library instead of calling it explicitly, there are much better and safer methods of doing so.  

