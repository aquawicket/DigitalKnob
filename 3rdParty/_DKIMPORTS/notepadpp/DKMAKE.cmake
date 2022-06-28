if(NOT WIN_HOST)
	return()
endif()
	
# https://notepad-plus-plus.org/downloads/v8.1.9/
#
# https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.9/npp.8.1.9.portable.zip

### VERSION ###
dk_set(NOTEPADPP_VERSION 8.1.9)
dk_set(NOTEPADPP_NAME "npp.${NOTEPADPP_VERSION}.portable")
dk_set(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v${NOTEPADPP_VERSION}/${NOTEPADPP_NAME}.zip)
dk_set(NOTEPADPP ${3RDPARTY}/${NOTEPADPP_NAME})
dk_set(NOTEPADPP_EXE ${NOTEPADPP}/notepadpp.exe)

### INSTALL ###
#dk_import(${NOTEPADPP_DL} ${NOTEPADPP})
dk_import(${NOTEPADPP_DL} ${NOTEPADPP})
