include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/ArtifexSoftware/ghostpdl-downloads
# https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe
# https://silentinstallhq.com/ghostscript-silent-install-how-to-guide/
if(NOT WIN_HOST)
	dk_undepend(ghostscript)
	dk_return()
endif()


### IMPORT ###
#dk_set(GHOSTSCRIPT "${ProgramFiles}/gs/gs9.22/bin")
#dk_import(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe)
dk_set(GHOSTSCRIPT ${DK3RDPARTY_DIR}/ghostscript-9.22)
if(NOT EXISTS ${GHOSTSCRIPT}/bin)
	dk_download(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe ${DKDOWNLOAD_DIR}/gs922w64.exe)
	dk_command(${DKDOWNLOAD_DIR}/gs922w64.exe /S /D=${GHOSTSCRIPT})
endif()
