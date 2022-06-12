# https://github.com/fmtlib/fmt
# https://fmt.dev/latest/index.html

### DEPENDS ###
DKDEPEND(python)

### IMPORT ###
DKIMPORT(https://github.com/fmtlib/fmt.git PATCH)

### INCLUDE/LINK ###
DKINCLUDE(${FMT}/include)
#WIN_DEBUG_DKLIB(${FMT}/${OS}/${DEBUG_DIR}/fmtd.lib)
#WIN_RELEASE_DKLIB(${FMT}/${OS}/${RELEASE_DIR}/fmt.lib)
#UNIX_DEBUG_DKLIB(${FMT}/${OS}/${DEBUG_DIR}/libfmtd.a)
#UNIX_RELEASE_DKLIB(${FMT}/${OS}/${RELEASE_DIR}/libfmt.a)

### GENERATE ###
#DKSETPATH(${FMT}/${BUILD_DIR})
#DKQCOMMAND(${DKCMAKE_BUILD} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE ${FMT})

### COMPILE ###
#VS(${FMT_NAME} FMT.sln fmt)  # windows, android
#XCODE(${FMT_NAME} fmt)       # mac, ios, iossim
#LINUX_DKQCOMMAND(make fmt)   
#RASPBERRY_DKQCOMMAND(make fmt)