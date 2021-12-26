# https://github.com/VerySleepy/verysleepy
# http://www.codersnotes.com/sleepy/
#
# https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe
# https://github.com/VerySleepy/verysleepy/archive/refs/tags/v0.91.zip (source)

### VERSION ###
WIN_SET(VERYSLEEPY_VERSION 0.91)
WIN_SET(VERYSLEEPY_NAME verysleepy-${VERYSLEEPY_VERSION})
WIN_SET(VERYSLEEPY_DL https://github.com/VerySleepy/verysleepy/releases/download/v0.91/${VERYSLEEPY_NAME}.exe)
WIN32_SET(VERYSLEEPY "C:/Program Files/Very Sleepy/32")
WIN64_SET(VERYSLEEPY "C:/Program Files/Very Sleepy")
WIN_SET(VERYSLEEPY_EXE "${VERYSLEEPY}/sleepy.exe")

### INSTALL ###
DKINSTALL(${VERYSLEEPY_DL} verysleepy ${VERYSLEEPY})
