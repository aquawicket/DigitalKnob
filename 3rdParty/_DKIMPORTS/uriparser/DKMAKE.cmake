# https://github.com/uriparser/uriparser

### INSTALL ###
dk_import(https://github.com/uriparser/uriparser.git)


### LINK ###
dk_define			(URI_STATIC_BUILD)
dk_include			(${URIPARSER}/include)
UNIX_dk_libDebug	(${URIPARSER}/${OS}/${DEBUG_DIR}/liburiparser.a)
UNIX_dk_libRelease	(${URIPARSER}/${OS}/${RELEASE_DIR}/liburiparser.a)
WIN_dk_libDebug		(${URIPARSER}/${OS}/${DEBUG_DIR}/uriparser.lib)
WIN_dk_libRelease	(${URIPARSER}/${OS}/${RELEASE_DIR}/uriparser.lib)


### GENERATE ###
dk_configure(${URIPARSER}
	-DURIPARSER_BUILD_DOCS=OFF
	-DURIPARSER_BUILD_TESTS=OFF)


### COMPILE ###
dk_build(${URIPARSER} uriparser)
