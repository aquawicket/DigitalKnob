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
dk_queueCommand(${DKCMAKE_BUILD} 
	${LIBUV_CMAKE}
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${UWEBSOCKETS})

### COMPILE ###
dk_build(${UWEBSOCKETS} uWS)

###### NON CMAKE #########
### GENERATE / COMPILE ###
#DEBUG_dk_setPath		(${UWEBSOCKETS}/${OS}/${DEBUG_DIR})
#DEBUG_dk_queueShell	(${DKCONFIGURE_BUILD})
#DEBUG_dk_queueShell		(make)
#RELEASE_dk_setPath		(${UWEBSOCKETS}/${OS}/${RELEASE_DIR})
#RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
#RELEASE_dk_queueShell	(make)

#dk_setPath		(${UWEBSOCKETS})
#dk_queueShell	(make)
##########################

