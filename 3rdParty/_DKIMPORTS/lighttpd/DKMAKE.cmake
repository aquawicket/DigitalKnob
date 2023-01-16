# https://github.com/lighttpd/lighttpd1.4.git


### IMPORT ###
dk_import(https://github.com/lighttpd/lighttpd1.4.git)


### LINK ###
dk_include			(${LIGHTTPD}/lib)
DEBUG_dk_include	(${LIGHTTPD}/${OS}/${DEBUG_DIR})
RELEASE_dk_include	(${LIGHTTPD}/${OS}/${RELEASE_DIR})
WIN_dk_libDebug		(${LIGHTTPD}/${OS}/lib/${DEBUG_DIR}/liblighttpd.lib)
WIN_dk_libRelease	(${LIGHTTPD}/${OS}/lib/${RELEASE_DIR}/liblighttpd.lib)
UNIX_dk_libDebug	(${LIGHTTPD}/${OS}/lib/${DEBUG_DIR}/liblighttpd.a)
UNIX_dk_libRelease	(${LIGHTTPD}/${OS}/lib/${RELEASE_DIR}/liblighttpd.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${LIGHTTPD}) # -DLWS_WITH_SSL=OFF


### COMPILE ###
dk_build(${LIGHTTPD} LIGHTTPD)
