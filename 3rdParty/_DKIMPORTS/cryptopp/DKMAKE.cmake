## https://www.cryptopp.com/

### VERSION ###
DKSET(CRYPTO_VERSION 600)

### INSTALL ###
## https://github.com/webstorage119/website-1/raw/master/cryptopp600.zip
DKINSTALL(https://github.com/webstorage119/website-1/raw/master/cryptopp${CRYPTO_VERSION}.zip cryptopp cryptopp${CRYTO_VERSION})	
DKSET(CRYPTO ${3RDPARTY}/cryptopp${CRYTO_VERSION})


### LINK ###
WIN_DEBUG_LIB(${CRYPTO}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
WIN_RELEASE_LIB(${CRYPTO}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)



### COMPILE ###
WIN_PATH(${CRYPTO}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${CRYPTO})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN65 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${CRYPTO})
WIN_VS(cryptopp${CRYTO_VERSION} cryptopp.sln cryptopp-static)
