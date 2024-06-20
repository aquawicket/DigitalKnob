message("fmt/DKMAKE.cmake")
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/fmtlib/fmt
# https://fmt.dev/latest/index.html


### DEPENDS ###
#dk_depend(python)


### IMPORT ###
dk_import(https://github.com/fmtlib/fmt.git BRANCH master)# PATCH)


### INCLUDE/LINK ###
dk_define(FMT_HEADER_ONLY)
dk_include(${FMT}/include)
#UNIX_dk_libDebug	(${FMT}/${OS}/${DEBUG_DIR}/libfmtd.a)
#UNIX_dk_libRelease	(${FMT}/${OS}/${RELEASE_DIR}/libfmt.a)
#WIN_dk_libDebug	(${FMT}/${OS}/${DEBUG_DIR}/fmtd.lib)
#WIN_dk_libRelease	(${FMT}/${OS}/${RELEASE_DIR}/fmt.lib)


### GENERATE ###
#dk_configure(${FMT} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE)


### COMPILE ###
#dk_build(${FMT} fmt)
