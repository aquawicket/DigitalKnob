# https://github.com/uNetworking/uWebSockets


### DEPEND ###
dk_depend(libuv)
dk_depend(openssl)
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/uNetworking/uWebSockets.git BRANCH v0.14 PATCH)
dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v0.14.8.zip PATCH)
#dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v20.36.0.zip)


### LINK ###
dk_include				(${UWEBSOCKETS})
dk_include				(${UWEBSOCKETS}/${OS})
if(MSVC)
	WIN_dk_libDebug		(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.lib)
	WIN_dk_libRelease	(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.lib)
else()
	dk_libDebug			(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/libuWS.a)
	dk_libRelease		(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/libuWS.a)
endif()



### GENERATE ###
dk_configure(${UWEBSOCKETS}
			${LIBUV_CMAKE}
			${OPENSSL_CMAKE}
			${ZLIB_CMAKE})


### COMPILE ###
dk_build(${UWEBSOCKETS} uWS)


###### NON CMAKE #########
#DEBUG_dk_configure			(${UWEBSOCKETS})
#DEBUG_dk_build				(${UWEBSOCKETS})
##########################

