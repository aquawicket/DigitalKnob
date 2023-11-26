# FIXME:  Install to /3rdParty only

# https://github.com/doxygen/doxygen.git
# https://sourceforge.net/projects/doxygen
if(NOT WIN_HOST)
	dk_undepend(doxygen)
	dk_return()
endif()


### IMPORT ###
LINUX_HOST_dk_set(DOXYGEN_EXE "/Applications/Doxygen.app") #FIXME
if(NOT EXISTS ${DOXYGEN_EXE})
	LINUX_HOST_dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6.linux.bin.tar.gz)
	#LINUX_HOST_dk_command(${DKDOWNLOAD}/doxygen-1.9.6.linux.bin.tar.gz) #FIXME
endif()

MAC_HOST_dk_set(DOXYGEN_EXE "/Applications/Doxygen.app") #FIXME
if(NOT EXISTS ${DOXYGEN_EXE})
	MAC_HOST_dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/Doxygen-1.9.6.dmg) #FIXME:  The Downloaded file is a BYPASS file .dmg
	MAC_HOST_dk_command(${DKDOWNLOAD}/Doxygen-1.9.6.dmg)
endif()

WIN_HOST_dk_set(DOXYGEN_EXE "C:/Program Files/doxygen/bin/doxygen.exe")
if(NOT EXISTS ${DOXYGEN_EXE})
	WIN_HOST_dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6-setup.exe)
	WIN_HOST_dk_command(${DKDOWNLOAD}/doxygen-1.9.6-setup.exe)
endif()
