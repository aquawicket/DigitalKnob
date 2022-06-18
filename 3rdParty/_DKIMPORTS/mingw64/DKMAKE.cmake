if(NOT WIN_HOST)
	return()
endif()

dk_set(MINGW64_VERSION 8.1.0)
dk_set(MINGW64_DL https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z)
dk_set(MINGW64_NAME mingw64-${MINGW64_VERSION})
dk_set(MINGW64 ${3RDPARTY}/${MINGW64_NAME})
DKINSTALL(${MINGW64_DL} mingw64 ${MINGW64})
