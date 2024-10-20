#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/Homebrew/brew
# https://brew.sh/
if(NOT MAC_HOST)
	dk_undepend(homebrew)
	dk_return()
endif()

#dk_import(https://github.com/Homebrew/brew)

MAC_dk_queueCommand("ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
# https://github.com/Homebrew/brew/issues/10368
MAC_dk_queueCommand(rm -fr "$(brew --repo homebrew/core)")
MAC_dk_queueCommand(brew tap homebrew/core)
