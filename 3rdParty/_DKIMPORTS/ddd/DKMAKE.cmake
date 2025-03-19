#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


# https://www.gnu.org/software/ddd/
# https://ftp.gnu.org/gnu/ddd/ddd-3.3.12.tar.gz


dk_load(dk_builder)

### IMPORT ###
#dk_import(https://ftp.gnu.org/gnu/ddd/ddd-3.3.12.tar.gz)


# TODO
# sudo apt-get install ddd
#dk_depend(sudo)
#LINUX_HOST_dk_command(${SUDO_EXE} apt -y install ddd)
dk_installPackage(ddd)