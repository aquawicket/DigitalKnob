# https://github.com/emscripten-core/emsdk
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip


dk_import(https://github.com/emscripten-core/emsdk.git BRANCH main)


#WIN_dk_command(${EMSDK}/emsdk update)
#dk_command(${EMSDK}/emsdk install latest)
#WIN_dk_command(${EMSDK}/emsdk install activate latest)
#WIN_dk_command(${EMSDK}/emsdk_env.bat)

dk_command(${EMSDK}/emsdk install latest)
dk_command(${EMSDK}/emsdk activate latest)
dk_command(${EMSDK}/emsdk_env)
WIN_dk_command(${EMSDK}/emsdk install mingw-4.6.2-32bit)
WIN_dk_command(${EMSDK}/emsdk activate mingw-4.6.2-32bit)


######################################################################################################################
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip
# dk_import(https://github.com/emscripten-core/emsdk.git)
# #dk_set(EMSDK_VERSION 2.0.26)
# #dk_set(EMSDK_NAME emsdk-${EMSCRIPTEN_VERSION})
# #dk_set(EMSDK_DL https://github.com/emscripten-core/emsdk/archive/refs/tags/${EMSCRIPTEN_VERSION}.zip)
# #dk_set(EMSDK ${3RDPARTY}/${EMSCRIPTEN_NAME})
#if(WIN_HOST)
#	if(NOT EXISTS ${EMSDK})
#		dk_set(CURRENT_DIR ${DKDOWNLOAD})
#		## dk_download(www.internet.com/emsdk-portable-64bit.zip) ## find an online link
#		dk_extract(${DKDOWNLOAD}/emsdk-portable-64bit.zip ${3RDPARTY}/emsdk-portable-64bit)
#		dk_copy(${DKIMPORTS}/emsdk-portable-64bit/.emscripten ${3RDPARTY}/emsdk-portable-64bit/.emscripten OVERWRITE)
#		dk_set(CURRENT_DIR ${3RDPARTY}/emsdk-portable-64bit)
#		dk_command(${3RDPARTY}/emsdk-portable-64bit/emsdk update)
#		dk_command(${3RDPARTY}/emsdk-portable-64bit/emsdk install latest)
#		dk_command(${3RDPARTY}/emsdk-portable-64bit/emsdk install activate latest)
#		dk_command(${3RDPARTY}/emsdk-portable-64bit/emsdk_env.bat)
#	endif()
#else()
#	dk_set(CURRENT_DIR ${DKDOWNLOAD})
#	## dk_download(www.internet.com/emsdk-portable.tar.gz) ## find an online link
#	dk_extract(${DKDOWNLOAD}/emsdk-portable.tar.gz ${3RDPARTY}/emsdk-portable)
#	dk_copy(${DKIMPORTS}/emsdk-portable/.emscripten ${3RDPARTY}/emsdk-portable/.emscripten OVERWRITE)
#	dk_set(CURRENT_DIR ${3RDPARTY}/emsdk-portable)
#	dk_command(${3RDPARTY}/emsdk-portable/emsdk update)
#	dk_command(${3RDPARTY}/emsdk-portable/emsdk install latest)
#	dk_command(${3RDPARTY}/emsdk-portable/emsdk install activate latest)
#	dk_command(${3RDPARTY}/emsdk-portable/source ./emsdk_env.sh)
#endif()
