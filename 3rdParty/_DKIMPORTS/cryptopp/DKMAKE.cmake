### VERSION ###
DKSET(CRYPTO_VERSION 600)

### INSTALL ###
DKINSTALL(https://src.fedoraproject.org/lookaside/pkgs/rpms/cryptopp/cryptopp${CRYTO_VERSION}.zip/sha512/7a60c28be1fc9418adeabe8c66d868b46e65fb3d77d308b9431b16905cde7faa670180619150e849ae44d70f44aa8501a0a0c4354ec84f194fd8138d14aca9bf/cryptopp${CRYTO_VERSION}.zip cryptopp cryptopp${CRYTO_VERSION})	
DKSET(CRYPTO ${3RDPARTY}/cryptopp${CRYTO_VERSION})


### LINK ###
WIN_DEBUG_LIB(${CRYPTO}/${OS}/Debug/cryptopp-static.lib)
WIN_RELEASE_LIB(${CRYPTO}/${OS}/Release/cryptopp-static.lib)



### COMPILE ###
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -S ${CRYPTO} -B ${CRYPTO}/${OS})
WIN32_VS_DEBUG(cryptopp${CRYTO_VERSION} cryptopp.sln cryptopp-static)
WIN32_VS_RELEASE(cryptopp${CRYTO_VERSION} cryptopp.sln cryptopp-static)


WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN65 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -S ${CRYPTO} -B ${CRYPTO}/${OS})
WIN64_VS_DEBUG(cryptopp${CRYTO_VERSION} cryptopp.sln cryptopp-static)
WIN64_VS_RELEASE(cryptopp${CRYTO_VERSION} cryptopp.sln cryptopp-static)