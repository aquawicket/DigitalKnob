include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/jasper-software/jasper.git


### IMPORT ###
#dk_import(https://github.com/jasper-software/jasper.git)
dk_import(https://github.com/jasper-software/jasper/archive/refs/heads/master.zip)


### LINK ###
dk_include				(${JASPER}/include)
dk_include				(${JASPER}/${OS})
ANDROID_TARGET_dk_libDebug		(${JASPER}/${OS}/src/libjasper/jasperd.a)
ANDROID_TARGET_dk_libRelease	(${JASPER}/${OS}/src/libjasper/jasper.a)
APPLE_dk_libDebug		(${JASPER}/${OS}/src/libjasper/libjasper.a)
APPLE_dk_libRelease		(${JASPER}/${OS}/src/libjasper/libjasper.a)
EMSCRIPTEN_TARGET_dk_libDebug	(${JASPER}/${OS}/${DEBUG_DIR}/src/libjasper/libjasper.a)
EMSCRIPTEN_TARGET_dk_libRelease(${JASPER}/${OS}/${RELEASE_DIR}/src/libjasper/libjasper.a)
LINUX_TARGET_dk_libDebug		(${JASPER}/${OS}/${DEBUG_DIR}/src/libjasper/libjasper.a)
LINUX_TARGET_dk_libRelease		(${JASPER}/${OS}/${RELEASE_DIR}/src/libjasper/libjasper.a)
RASPBERRY_TARGET_dk_libDebug	(${JASPER}/${OS}/${DEBUG_DIR}/src/libjasper/libjasper.a)
RASPBERRY_TARGET_dk_libRelease	(${JASPER}/${OS}/${RELEASE_DIR}/src/libjasper/libjasper.a)
WIN_TARGET_dk_libDebug			(${JASPER}/${OS}/src/libjasper/jasperd.lib)
WIN_TARGET_dk_libRelease		(${JASPER}/${OS}/src/libjasper/jasper.lib)


### GENERATE ###
dk_configure(${JASPER})


### COMPILE ###
dk_build(${JASPER})
