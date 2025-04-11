#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Uninstall keylogger ######
# https://github.com/GiacomoLaw/Keylogger
# https://github.com/GiacomoLaw/Keylogger/archive/142eebd7dee0ac6067642804e80df4b4f375a7bd.zip

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParam	("$ENV{DKIMPORTS_DIR}/keylogger/dkconfig.txt" KEYLOGGER_IMPORT)

#dk_uninstall	(${KEYLOGGER_IMPORT}) # TODO
