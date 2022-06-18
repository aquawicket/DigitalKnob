# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
#
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

dk_import(https://github.com/emscripten-core/emsdk.git)

#dk_set(EMSCRIPTEN_VERSION 2.0.26)
#dk_set(EMSCRIPTEN_NAME emsdk-${EMSCRIPTEN_VERSION})
#dk_set(EMSCRIPTEN_DL https://github.com/emscripten-core/emsdk/archive/refs/tags/${EMSCRIPTEN_VERSION}.zip)
#dk_set(EMSCRIPTEN ${3RDPARTY}/${EMSCRIPTEN_NAME})

IF(WIN_HOST)
	IF(NOT EXISTS ${EMSCRIPTEN})
		dk_set(CURRENT_DIR ${DKDOWNLOAD})
		## dk_download(www.internet.com/emsdk-portable-64bit.zip) ## find an online link
		dk_extract(${DKDOWNLOAD}/emsdk-portable-64bit.zip ${3RDPARTY}/emsdk-portable-64bit)
		dk_copy(${DKIMPORTS}/emsdk-portable-64bit/.emscripten ${3RDPARTY}/emsdk-portable-64bit/.emscripten true)
		dk_set(CURRENT_DIR ${3RDPARTY}/emsdk-portable-64bit)
		DKCOMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk update)
		DKCOMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk install latest)
		DKCOMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk install activate latest)
		DKCOMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk_env.bat)
	ENDIF()
else()
	dk_set(CURRENT_DIR ${DKDOWNLOAD})
	## dk_download(www.internet.com/emsdk-portable.tar.gz) ## find an online link
	dk_extract(${DKDOWNLOAD}/emsdk-portable.tar.gz ${3RDPARTY}/emsdk-portable)
	dk_copy(${DKIMPORTS}/emsdk-portable/.emscripten ${3RDPARTY}/emsdk-portable/.emscripten true)
	dk_set(CURRENT_DIR ${3RDPARTY}/emsdk-portable)
	DKCOMMAND(${3RDPARTY}/emsdk-portable/emsdk update)
	DKCOMMAND(${3RDPARTY}/emsdk-portable/emsdk install latest)
	DKCOMMAND(${3RDPARTY}/emsdk-portable/emsdk install activate latest)
	DKCOMMAND(${3RDPARTY}/emsdk-portable/source ./emsdk_env.sh)
ENDIF()