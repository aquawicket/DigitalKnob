# https://github.com/htacg/tidy-html5.git
# https://github.com/htacg/tidy-html5/archive/5.7.28.zip
# https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/htacg/tidy-html5.git)


### LINK ###
EMSCRIPTEN_dk_define	(HAS_FUTIME=0)
dk_include				(${TIDY_HTML5})
dk_include				(${TIDY_HTML5}/include)
dk_include				(${TIDY_HTML5}/${OS})
ANDROID_dk_include		(${TIDY_HTML5}/${OS}/$(BUILD_TYPE)/jni)

if(MSVC)
	WIN_dk_libDebug		(${TIDY_HTML5}/${OS}/${DEBUG_DIR}/tidy_staticd.lib)
	WIN_dk_libRelease	(${TIDY_HTML5}/${OS}/${RELEASE_DIR}/tidy_static.lib)
else()
	dk_libDebug			(${TIDY_HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
	dk_libRelease		(${TIDY_HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
endif()



### GENERATE ###
if(EMSCRIPTEN)
	dk_queueCommand		(${DKCMAKE_BUILD} ${ZLIB_CMAKE} "-DCMAKE_C_FLAGS=-DHAS_FUTIME=0" ${TIDY_HTML5})
else()
	dk_queueCommand		(${DKCMAKE_BUILD} ${ZLIB_CMAKE} ${TIDY_HTML5})
endif()


### COMPILE ###
dk_build				(${TIDY_HTML5} tidy-static)
