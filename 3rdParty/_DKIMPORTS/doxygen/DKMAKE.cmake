# https://github.com/doxygen/doxygen.git
# https://sourceforge.net/projects/doxygen/files/rel-1.8.13/doxygen-1.8.13-setup.exe
if(NOT WIN_HOST)
	return()
endif()


### IMPORT ###
dk_set(DOXYGEN_EXE "C:/Program Files/doxygen/bin/doxygen.exe")
IF(NOT EXISTS ${DOXYGEN_EXE})
	dk_import(https://sourceforge.net/projects/doxygen/files/rel-1.8.13/doxygen-1.8.13-setup.exe)
	dk_set(QUEUE_BUILD ON)
	WIN32_dk_queueCommand(${DKDOWNLOAD}/doxygen-1.8.13-setup.exe)
ENDIF()
