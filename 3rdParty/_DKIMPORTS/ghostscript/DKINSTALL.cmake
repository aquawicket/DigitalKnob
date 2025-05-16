#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ ghostscript ############
# https://github.com/ArtifexSoftware/ghostpdl-downloads
# https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe
# https://silentinstallhq.com/ghostscript-silent-install-how-to-guide
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_undepend(ghostscript)
	dk_return()
endif()

### IMPORT ###
#dk_set(GHOSTSCRIPT "${ProgramFiles}/gs/gs9.22/bin")
#dk_import(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe)
dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
dk_set(GHOSTSCRIPT $ENV{DK3RDPARTY_DIR}/ghostscript-9.22)
if(NOT EXISTS ${GHOSTSCRIPT}/bin)
	dk_download(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe $ENV{DKDOWNLOAD_DIR}/gs922w64.exe)
	dk_command($ENV{DKDOWNLOAD_DIR}/gs922w64.exe /S /D=${GHOSTSCRIPT})
endif()
