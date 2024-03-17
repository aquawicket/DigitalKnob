# https://github.com/htacg/tidy-html5.git
# https://github.com/htacg/tidy-html5/archive/5.7.28.zip
# https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/htacg/tidy-html5.git)


dk_fileReplace(${TIDY_HTML5}/CMakeLists.txt "add_definitions ( -DLIBTIDY_VERSION" "#add_definitions ( -DLIBTIDY_VERSION")
dk_fileReplace(${TIDY_HTML5}/CMakeLists.txt "add_definitions ( -DRELEASE_DATE" "#add_definitions ( -DRELEASE_DATE")

### LINK ###
EMSCRIPTEN_dk_define	(HAS_FUTIME=0)
dk_include				(${TIDY_HTML5})
dk_include				(${TIDY_HTML5}/include)
dk_include				(${TIDY_HTML5}/${OS})
ANDROID_dk_include		(${TIDY_HTML5}/${OS}/$(BUILD_TYPE)/jni)

if(MSVC)
	WIN_dk_libDebug		(${TIDY_HTML5}/${OS}/${DEBUG_DIR}/tidy_staticd.lib)
	WIN_dk_libRelease	(${TIDY_HTML5}/${OS}/${RELEASE_DIR}/tidy_static.lib)
elseif(MINGW)
	WIN_dk_libDebug		(${TIDY_HTML5}/${OS}/${DEBUG_DIR}/libtidy_static.a)
	WIN_dk_libRelease	(${TIDY_HTML5}/${OS}/${RELEASE_DIR}/libtidy_static.a)
else()
	dk_libDebug			(${TIDY_HTML5}/${OS}/${DEBUG_DIR}/libtidy.a)
	dk_libRelease		(${TIDY_HTML5}/${OS}/${RELEASE_DIR}/libtidy.a)
endif()


### GENERATE ###
if(EMSCRIPTEN)
	dk_configure		(${TIDY_HTML5} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE} "-DCMAKE_C_FLAGS=-DHAS_FUTIME=0")
else()
	dk_configure		(${TIDY_HTML5} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE})
endif()


### COMPILE ###
dk_build				(${TIDY_HTML5} tidy-static)
