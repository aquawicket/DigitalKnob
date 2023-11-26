# https://github.com/bombela/backward-cpp.git


### IMPORT ###
#dk_import(https://github.com/bombela/backward-cpp/archive/refs/tags/v1.6.zip)
dk_import(https://github.com/bombela/backward-cpp.git)


### LINK ###
dk_include			(${BACKWARD-CPP})
#UNIX_dk_libDebug	(${BACKWARD-CPP}/${OS}/${DEBUG_DIR}/libbackward.a)
#UNIX_dk_libRelease	(${BACKWARD-CPP}/${OS}/${RELEASE_DIR}/libbackward.a)
#WIN_dk_libDebug	(${BACKWARD-CPP}/${OS}/${DEBUG_DIR}/backward.lib)
#WIN_dk_libRelease	(${BACKWARD-CPP}/${OS}/${RELEASE_DIR}/backward.lib)

if(ANDROID)
	dk_remove(${DKPLUGINS}/DK/backward.cpp NOERROR)
else()
	dk_copy(${BACKWARD-CPP}/backward.cpp ${DKPLUGINS}/DK/backward.cpp OVERWRITE)
endif()


### GENERATE ###
#dk_queueCommand(${DKCMAKE_BUILD} ${BACKWARD-CPP})


### COMPILE ###
#dk_build(${BACKWARD-CPP})
