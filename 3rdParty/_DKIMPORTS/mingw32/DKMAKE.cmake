if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### VERSION ###
DKSET(MINGW32 ${3RDPARTY}/mingw/mingw32)


### INSTALL ###
IF(NOT EXISTS ${3RDPARTY}/mingw/mingw32)
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.2/threads-posix/dwarf/i686-4.9.2-release-posix-dwarf-rt_v3-rev1.7z)
	DKEXTRACT(${DIGITALKNOB}/Download/i686-4.9.2-release-posix-dwarf-rt_v3-rev1.7z ${3RDPARTY}/mingw)
ENDIF()
##string(REPLACE ":" "" MINGW32 ${MINGW32})