#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://terminator-gtk3.readthedocs.io/en/latest/


#LINUX_HOST_dk_chdir(/usr)
dk_depend(sudo)
#LINUX_HOST_dk_command(${SUDO_EXE} apt -y install terminator) #FIXME sudo needed
#Mac_Host_dk_command(brew install terminator)
dk_installPackage(terminator)
