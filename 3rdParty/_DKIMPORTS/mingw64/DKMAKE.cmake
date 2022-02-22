if(NOT WIN_HOST)
	return()
endif()

# https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/4.9.2/threads-posix/seh/x86_64-4.9.2-release-posix-seh-rt_v3-rev1.7z
# https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z


### VERSION ###
DKSET(MINGW64_VERSION 8.1.0)
DKSET(MINGW64_NAME mingw64-${MINGW64_VERSION})
DKSET(MINGW64_DL https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z)
DKSET(MINGW64 ${3RDPARTY}/${MINGW64_NAME})


### INSTALL ###
DKINSTALL(${MINGW64_DL} mingw64 ${MINGW64})
