#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ homebrew ############
# https://github.com/Homebrew/brew
# https://brew.sh
dk_load(dk_builder)
if(NOT Mac_Host)
	dk_undepend(homebrew)
	dk_return()
endif()

#dk_import(https://github.com/Homebrew/brew)
dk_queueCommand("ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
# https://github.com/Homebrew/brew/issues/10368
dk_queueCommand(rm -fr "$(brew --repo homebrew/core)")
dk_queueCommand(brew tap homebrew/core)
