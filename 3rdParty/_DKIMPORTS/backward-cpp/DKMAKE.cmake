# https://github.com/bombela/backward-cpp.git


### IMPORT ###
dk_import(https://github.com/bombela/backward-cpp.git)


### LINK ###
dk_include			(${BACKWARD-CPP})
#UNIX_dk_libDebug	(${BACKWARD-CPP}/${OS}/${DEBUG_DIR}/libbackward.a)
#UNIX_dk_libRelease	(${BACKWARD-CPP}/${OS}/${RELEASE_DIR}/libbackward.a)
#WIN_dk_libDebug	(${BACKWARD-CPP}/${OS}/${DEBUG_DIR}/backward.lib)
#WIN_dk_libRelease	(${BACKWARD-CPP}/${OS}/${RELEASE_DIR}/backward.lib)

ANDROID_dk_remove(${DKPLUGINS}/DK/backward.cpp NOERROR)
if(NOT ANDROID)
	dk_copy(${BACKWARD-CPP}/backward.cpp ${DKPLUGINS}/DK/backward.cpp OVERWRITE)
endif()


### GENERATE ###
#dk_queueCommand(${DKCMAKE_BUILD} ${BACKWARD-CPP})


### COMPILE ###
#dk_build(${BACKWARD-CPP})
