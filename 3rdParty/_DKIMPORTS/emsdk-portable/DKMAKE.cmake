##https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/

IF(MAC OR LINUX)
	IF(NOT EXISTS "${3RDPARTY}/emsdk-portable/emscripten")
		DKSET(CURRENT_DIR ${DIGITALKNOB}/Download)
		## DKDOWNLOAD(www.internet.com/emsdk-portable.tar.gz) ## find an online link
		DKEXTRACT(${DIGITALKNOB}/Download/emsdk-portable.tar.gz ${3RDPARTY}/emsdk-portable)
		DKCOPY(${3RDPARTY}/_DKIMPORTS/emsdk-portable/.emscripten ${3RDPARTY}/emsdk-portable/.emscripten true)
		DKSET(CURRENT_DIR ${3RDPARTY}/emsdk-portable)
		DKSET(QUEUE_BUILD ON)
		MAC_COMMAND(${3RDPARTY}/emsdk-portable/emsdk update)
		MAC_COMMAND(${3RDPARTY}/emsdk-portable/emsdk install latest)
		MAC_COMMAND(${3RDPARTY}/emsdk-portable/emsdk install activate latest)
		MAC_COMMAND(${3RDPARTY}/emsdk-portable/source ./emsdk_env.sh)
	ENDIF()
	
	DKSET(EMSCRIPTEN ${3RDPARTY}/emsdk-portable)
ENDIF()

IF(CMAKE_HOST_WIN32)
	IF(NOT EXISTS "${3RDPARTY}/emsdk-portable-64bit/emscripten")
		DKSET(CURRENT_DIR ${DIGITALKNOB}/Download)
		## DKDOWNLOAD(www.internet.com/emsdk-portable-64bit.zip) ## find an online link
		DKEXTRACT(${DIGITALKNOB}/Download/emsdk-portable-64bit.zip ${3RDPARTY}/emsdk-portable-64bit)
		DKCOPY(${3RDPARTY}/_DKIMPORTS/emsdk-portable-64bit/.emscripten ${3RDPARTY}/emsdk-portable-64bit/.emscripten true)
		DKSET(CURRENT_DIR ${3RDPARTY}/emsdk-portable-64bit)
		DKSET(QUEUE_BUILD ON)
		WIN32_COMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk update)
		WIN32_COMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk install latest)
		WIN32_COMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk install activate latest)
		WIN32_COMMAND(${3RDPARTY}/emsdk-portable-64bit/emsdk_env.bat)
	ENDIF()
	DKSET(EMSCRIPTEN ${3RDPARTY}/emsdk-portable-64bit)
ENDIF()