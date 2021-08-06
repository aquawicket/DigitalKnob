## https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.2/threads-posix/dwarf/i686-4.9.2-release-posix-dwarf-rt_v3-rev1.7z

### VERSION ###
DKSET(MINGW32_VERSION 4.9.2)
DKSET(MINGW32_NAME mingw32-${MINGW32_VERSION})
DKSET(MINGW32_DL https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/${MINGW32_VERSION}/threads-posix/dwarf/i686-${MINGW32_VERSION}-release-posix-dwarf-rt_v3-rev1.7z)
DKSET(MINGW32 ${3RDPARTY}/${MINGW32_NAME})

### INSTALL ###
DKINSTALL(${MINGW32_DL} mingw32 ${MINGW32})
