# https://github.com/ArtifexSoftware/ghostpdl-downloads
# https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe
if(NOT WIN_HOST)
	return()
endif()


### IMPORT ###
dk_set(GHOSTSCRIPT "C:/Program Files/gs/gs9.22/bin")
IF(NOT EXISTS ${GHOSTSCRIPT})
	#dk_download(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe gs922w64.exe)
	dk_import(https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe)
	dk_command(${DKDOWNLOAD}/gs922w64.exe)
ENDIF()