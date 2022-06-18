# https://github.com/fmtlib/fmt
# https://fmt.dev/latest/index.html

### DEPENDS ###
dk_depend(python)

### IMPORT ###
dk_import(https://github.com/fmtlib/fmt.git PATCH)

### INCLUDE/LINK ###
dk_define(FMT_HEADER_ONLY)
dk_include(${FMT}/include)
#WIN_DEBUG_DKLIB(${FMT}/${OS}/${DEBUG_DIR}/fmtd.lib)
#WIN_RELEASE_DKLIB(${FMT}/${OS}/${RELEASE_DIR}/fmt.lib)
#UNIX_DEBUG_DKLIB(${FMT}/${OS}/${DEBUG_DIR}/libfmtd.a)
#UNIX_RELEASE_DKLIB(${FMT}/${OS}/${RELEASE_DIR}/libfmt.a)

### GENERATE ###
#dk_setPath(${FMT}/${BUILD_DIR})
#dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE ${FMT})

### COMPILE ###
#VS(${FMT_NAME} FMT.sln fmt)  # windows, android
#XCODE(${FMT_NAME} fmt)       # mac, ios, iossim
#LINUX_dk_queueCommand(make fmt)   
#RASPBERRY_dk_queueCommand(make fmt)