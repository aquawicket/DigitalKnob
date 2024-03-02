# https://github.com/bombela/backward-cpp.git


### IMPORT ###
#dk_import(https://github.com/bombela/backward-cpp/archive/refs/tags/v1.6.zip)
dk_import(https://github.com/bombela/backward-cpp.git)


### LINK ###
dk_include			(${BACKWARD_CPP})
#UNIX_dk_libDebug	(${BACKWARD_CPP}/${OS}/${DEBUG_DIR}/libbackward.a)
#UNIX_dk_libRelease	(${BACKWARD_CPP}/${OS}/${RELEASE_DIR}/libbackward.a)
#WIN_dk_libDebug	(${BACKWARD_CPP}/${OS}/${DEBUG_DIR}/backward.lib)
#WIN_dk_libRelease	(${BACKWARD_CPP}/${OS}/${RELEASE_DIR}/backward.lib)

if(ANDROID)
	dk_remove(${DKPLUGINS_DIR}/DK/backward.cpp NOERROR)
else()
	dk_copy(${BACKWARD_CPP}/backward.cpp ${DKPLUGINS_DIR}/DK/backward.cpp OVERWRITE)
endif()


### GENERATE ###
#dk_queueCommand(${DKCMAKE_BUILD} ${BACKWARD_CPP})


### COMPILE ###
#dk_build(${BACKWARD_CPP})
