#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ filezilla ############
# https://filezilla-project.org/

dk_set(FILEZILLA_EXE "C:\\Program Files\\FileZilla FTP Client\\filezilla.exe")

### IMPORT ###
if(NOT EXISTS ${FILEZILLA_EXE})
	dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_getFileParam 	("${DKIMPORTS_DIR}/filezilla/dkconfig.txt" FILEZILLA_DL)
	dk_import			(${FILEZILLA_DL})
endif()
