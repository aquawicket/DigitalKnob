include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/bombela/backward-cpp.git


### IMPORT ###
dk_import(https://github.com/bombela/backward-cpp/archive/refs/heads/master.zip)
#dk_import(https://github.com/bombela/backward-cpp.git)


### LINK ###
dk_include			(${BACKWARD_CPP})
#UNIX_dk_libDebug	(${BACKWARD_CPP}/${OS}/${DEBUG_DIR}/libbackward.a)
#UNIX_dk_libRelease	(${BACKWARD_CPP}/${OS}/${RELEASE_DIR}/libbackward.a)
#WIN_dk_libDebug	(${BACKWARD_CPP}/${OS}/${DEBUG_DIR}/backward.lib)
#WIN_dk_libRelease	(${BACKWARD_CPP}/${OS}/${RELEASE_DIR}/backward.lib)

if(ANDROID)
	dk_delete(${DKPLUGINS_DIR}/DK/backward.cpp NO_HALT)
else()
	dk_copy(${BACKWARD_CPP}/backward.cpp ${DKPLUGINS_DIR}/DK/backward.cpp OVERWRITE)
endif()


### GENERATE ###
#dk_configure(${BACKWARD_CPP})


### COMPILE ###
#dk_build(${BACKWARD_CPP})
