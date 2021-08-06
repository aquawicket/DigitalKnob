# https://www.cryptopp.com/
#
# https://github.com/webstorage119/website-1/raw/master/cryptopp600.zip

### VERSION ###
DKSET(CRYPTO_VERSION 600)
DKSET(CRYPTO_NAME cryptopp${CRYTO_VERSION})
DKSET(CRYPTO_DL https://github.com/webstorage119/website-1/raw/master/${CRYPTO_NAME}.zip)
DKSET(CRYPTO ${3RDPARTY}/${CRYPTO_NAME})


### INSTALL ###
DKINSTALL(${CRYPTO_DL} cryptopp ${CRYPTO})


### LINK ###
WIN_DEBUG_LIB(${CRYPTO}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
WIN_RELEASE_LIB(${CRYPTO}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)


### COMPILE ###
WIN_PATH(${CRYPTO}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} ${CRYPTO})
WIN64_COMMAND(${DKCMAKE_WIN64} ${CRYPTO})
WIN_VS(${CRYPTO_NAME} cryptopp.sln cryptopp-static)
