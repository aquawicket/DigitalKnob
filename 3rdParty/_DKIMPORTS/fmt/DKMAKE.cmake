# https://github.com/fmtlib/fmt
# https://fmt.dev/latest/index.html

### DEPENDS ###
dk_depend(python)

### IMPORT ###
dk_import(https://github.com/fmtlib/fmt.git PATCH)

### INCLUDE/LINK ###
dk_define(FMT_HEADER_ONLY)
dk_include(${FMT}/include)
#WIN_dk_libDebug(${FMT}/${OS}/${DEBUG_DIR}/fmtd.lib)
#WIN_dk_libRelease(${FMT}/${OS}/${RELEASE_DIR}/fmt.lib)
#UNIX_dk_libDebug(${FMT}/${OS}/${DEBUG_DIR}/libfmtd.a)
#UNIX_dk_libRelease(${FMT}/${OS}/${RELEASE_DIR}/libfmt.a)

### GENERATE ###
#dk_setPath(${FMT}/${BUILD_DIR})
#dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE ${FMT})

### COMPILE ###
#dk_visualStudio(${FMT_NAME} FMT.sln fmt)  # windows, android
#dk_xcode(${FMT_NAME} fmt)       # mac, ios, iossim
#LINUX_dk_queueCommand(make fmt)   
#RASPBERRY_dk_queueCommand(make fmt)