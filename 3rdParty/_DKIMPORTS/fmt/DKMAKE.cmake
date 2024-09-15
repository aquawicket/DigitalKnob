message("fmt/DKMAKE.cmake")
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/fmtlib/fmt
# https://fmt.dev/latest/index.html


### DEPENDS ###
#dk_depend(python3)


### IMPORT ###
#dk_import(https://github.com/fmtlib/fmt.git BRANCH master)# PATCH)
dk_import(https://github.com/fmtlib/fmt/archive/refs/heads/master.zip)



### INCLUDE/LINK ###
dk_define(FMT_HEADER_ONLY)
dk_include(${FMT}/include)
###### DEBUG for FMT LIBRARY ######

# moved to DKBuildFlags.cmake
# needed by FMT library
#if(MSVC)
#	dk_append(CMAKE_C_FLAGS /utf-8)
#	dk_append(CMAKE_CXX_FLAGS /utf-8)
#endif()

#UNIX_dk_libDebug	(${FMT}/${triple}/${DEBUG_DIR}/libfmtd.a)
#UNIX_dk_libRelease	(${FMT}/${triple}/${RELEASE_DIR}/libfmt.a)
#WIN_dk_libDebug	(${FMT}/${triple}/${DEBUG_DIR}/fmtd.lib)
#WIN_dk_libRelease	(${FMT}/${triple}/${RELEASE_DIR}/fmt.lib)


### GENERATE ###
#dk_configure(${FMT} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE)


### COMPILE ###
#dk_build(${FMT} fmt)
