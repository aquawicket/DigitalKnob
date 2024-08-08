include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://bitbucket.org/multicoreware/x265_git.git


### IMPORT ###
#dk_import(https://bitbucket.org/multicoreware/x265_git.git)
dk_import(https://bitbucket.org/multicoreware/x265_git/get/dd594f59d95198c6d8e4133b6002c18e47e7d6fe.zip)


### LINK ###
dk_include		(${X265}/include)
dk_include		(${X265}/${OS})
dk_libDebug		(${X265}/${OS}/${DEBUG_DIR}/libx265.a)
dk_libRelease	(${X265}/${OS}/${RELEASE_DIR}/libx265.a)


### GENERATE ###
dk_configure(${X265})


### COMPILE ###
dk_build(${X265})
