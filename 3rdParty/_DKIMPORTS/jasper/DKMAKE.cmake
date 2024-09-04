include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/jasper-software/jasper.git


### IMPORT ###
#dk_import(https://github.com/jasper-software/jasper.git)
dk_import(https://github.com/jasper-software/jasper/archive/refs/heads/master.zip)


### LINK ###
dk_include				(${JASPER}/include)
dk_include				(${JASPER}/${triple})
ANDROID_dk_libDebug		(${JASPER}/${triple}/src/libjasper/jasperd.a)
ANDROID_dk_libRelease	(${JASPER}/${triple}/src/libjasper/jasper.a)
APPLE_dk_libDebug		(${JASPER}/${triple}/src/libjasper/libjasper.a)
APPLE_dk_libRelease		(${JASPER}/${triple}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libDebug	(${JASPER}/${triple}/${DEBUG_DIR}/src/libjasper/libjasper.a)
EMSCRIPTEN_dk_libRelease(${JASPER}/${triple}/${RELEASE_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libDebug		(${JASPER}/${triple}/${DEBUG_DIR}/src/libjasper/libjasper.a)
LINUX_dk_libRelease		(${JASPER}/${triple}/${RELEASE_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libDebug	(${JASPER}/${triple}/${DEBUG_DIR}/src/libjasper/libjasper.a)
RASPBERRY_dk_libRelease	(${JASPER}/${triple}/${RELEASE_DIR}/src/libjasper/libjasper.a)
WIN_dk_libDebug			(${JASPER}/${triple}/src/libjasper/jasperd.lib)
WIN_dk_libRelease		(${JASPER}/${triple}/src/libjasper/jasper.lib)


### GENERATE ###
dk_configure(${JASPER})


### COMPILE ###
dk_build(${JASPER})
