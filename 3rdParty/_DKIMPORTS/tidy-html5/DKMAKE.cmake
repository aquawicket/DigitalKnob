# https://github.com/htacg/tidy-html5.git
# https://github.com/htacg/tidy-html5/archive/5.7.28.zip
# https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/htacg/tidy-html5.git)


### LINK ###
EMSCRIPTEN_dk_define	(HAS_FUTIME=0)
dk_include				(${TIDY-HTML5})
dk_include				(${TIDY-HTML5}/include)
dk_include				(${TIDY-HTML5}/${OS})
ANDROID_dk_include		(${TIDY-HTML5}/${OS}/$(BUILD_TYPE)/jni)
UNIX_dk_libDebug		(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
UNIX_dk_libRelease		(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
WIN_dk_libDebug			(${TIDY-HTML5}/${OS}/${DEBUG_DIR}/tidy_staticd.lib)
WIN_dk_libRelease		(${TIDY-HTML5}/${OS}/${RELEASE_DIR}/tidy_static.lib)


### GENERATE ###
if(EMSCRIPTEN)
	dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DHAS_FUTIME=0" ${ZLIB_CMAKE} ${TIDY-HTML5})
else()
	dk_queueCommand(${DKCMAKE_BUILD} ${ZLIB_CMAKE} ${TIDY-HTML5})
endif()


### COMPILE ###
dk_build(${TIDY-HTML5} tidy-static)
