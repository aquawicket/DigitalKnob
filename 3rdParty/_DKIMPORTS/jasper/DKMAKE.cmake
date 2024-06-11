include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/jasper-software/jasper.git


### IMPORT ###
dk_import(https://github.com/jasper-software/jasper.git)


### LINK ###
dk_include				(${JASPER}/include)
dk_include				(${JASPER}/${OS})
ANDROID_dk_libDebug		(${JASPER}/${OS}/src/libjasper/jasperd.a)
ANDROID_dk_libRelease	(${JASPER}/${OS}/src/libjasper/jasper.a)
APPLE_dk_libDebug		(${JASPER}/${OS}/src/libjasper/libjasper.a)
APPLE_dk_libRelease		(${JASPER}/${OS}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libDebug	(${JASPER}/${OS}/${DEBUG_DIR}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libRelease(${JASPER}/${OS}/${RELEASE_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libDebug		(${JASPER}/${OS}/${DEBUG_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libRelease		(${JASPER}/${OS}/${RELEASE_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libDebug	(${JASPER}/${OS}/${DEBUG_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libRelease	(${JASPER}/${OS}/${RELEASE_DIR}/src/libjasper/libjasper.a)
WIN_dk_libDebug			(${JASPER}/${OS}/src/libjasper/jasperd.lib)
WIN_dk_libRelease		(${JASPER}/${OS}/src/libjasper/jasper.lib)


### GENERATE ###
dk_configure(${JASPER})


### COMPILE ###
dk_build(${JASPER})
