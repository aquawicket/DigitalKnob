## https://www.cryptopp.com/

### VERSION ###
DKSET(CRYPTO_VERSION 600)
DKSET(CRYPTO_NAME cryptopp${CRYTO_VERSION})
DKSET(CRYPTO ${3RDPARTY}/${CRYPTO_NAME})


### INSTALL ###
## https://github.com/webstorage119/website-1/raw/master/cryptopp600.zip
DKINSTALL(https://github.com/webstorage119/website-1/raw/master/cryptopp${CRYPTO_VERSION}.zip cryptopp ${CRYPTO_NAME})	


### LINK ###
WIN_DEBUG_LIB(${CRYPTO}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
WIN_RELEASE_LIB(${CRYPTO}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)


### COMPILE ###
WIN_PATH(${CRYPTO}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} ${CRYPTO})
WIN64_COMMAND(${DKCMAKE_WIN64} ${CRYPTO})
WIN_VS(${CRYPTO_NAME} cryptopp.sln cryptopp-static)
