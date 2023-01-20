# https://github.com/ArtifexSoftware/ghostpdl-downloads
# https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe
# https://silentinstallhq.com/ghostscript-silent-install-how-to-guide/
if(NOT WIN_HOST)
	dk_undepend(ghostscript)
	dk_return()
endif()


### IMPORT ###
#dk_set(GHOSTSCRIPT "C:/Program Files/gs/gs9.22/bin")
#dk_import(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe)
dk_set(GHOSTSCRIPT ${3RDPARTY}/ghostscript-9.22)
if(NOT EXISTS ${GHOSTSCRIPT}/bin)
	dk_download(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe ${DKDOWNLOAD}/gs922w64.exe)
	dk_command(${DKDOWNLOAD}/gs922w64.exe /S /D=${GHOSTSCRIPT})
endif()
