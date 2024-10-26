#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ ghostscript ############
# https://github.com/ArtifexSoftware/ghostpdl-downloads
# https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe
# https://silentinstallhq.com/ghostscript-silent-install-how-to-guide
dk_load(dk_builder)
if(NOT WIN_HOST)
	dk_undepend(ghostscript)
	dk_return()
endif()

### IMPORT ###
#dk_set(GHOSTSCRIPT "${ProgramFiles}/gs/gs9.22/bin")
#dk_import(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe)
dk_validate(DK3RDPARTY_DIR "dk_DKBRANCH_DIR()")
dk_set(GHOSTSCRIPT ${DK3RDPARTY_DIR}/ghostscript-9.22)
if(NOT EXISTS ${GHOSTSCRIPT}/bin)
	dk_download(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe ${DKDOWNLOAD_DIR}/gs922w64.exe)
	dk_command(${DKDOWNLOAD_DIR}/gs922w64.exe /S /D=${GHOSTSCRIPT})
endif()
