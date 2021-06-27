### INSTALL ###
#IF(NOT WIN_64)
#	RETURN()
#ENDIF()

IF(NOT EXISTS ${3RDPARTY}/mingw/mingw64)
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/4.9.2/threads-posix/seh/x86_64-4.9.2-release-posix-seh-rt_v3-rev1.7z)
	DKEXTRACT(${DIGITALKNOB}/Download/x86_64-4.9.2-release-posix-seh-rt_v3-rev1.7z ${3RDPARTY}/mingw)
ENDIF()

DKSET(MINGW64 ${3RDPARTY}/mingw/mingw64)
string(REPLACE ":" "" MINGW64 ${MINGW64})