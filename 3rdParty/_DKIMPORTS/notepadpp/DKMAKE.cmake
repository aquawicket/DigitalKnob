if(NOT CMAKE_HOST_WIN32)
	return()
endif()
	
# https://notepad-plus-plus.org/downloads/v8.1.9/
#
# https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.9/npp.8.1.9.portable.zip

### VERSION ###
DKSET(NOTEPADPP_VERSION 8.1.9)
DKSET(NOTEPADPP_NAME "npp.${NOTEPADPP_VERSION}.portable")
DKSET(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v${NOTEPADPP_VERSION}/${NOTEPADPP_NAME}.zip)
DKSET(NOTEPADPP ${3RDPARTY}/${NOTEPADPP_NAME})
DKSET(NOTEPADPP_EXE ${NOTEPADPP}/notepadpp.exe)

### INSTALL ###
DKINSTALL(NOTEPADPP_DL notepadpp ${NOTEPADPP})
