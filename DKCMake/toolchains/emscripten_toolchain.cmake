message(STATUS "##############################################################")
message(STATUS "################# emscripten_toolchain.cmake #################")
message(STATUS "##############################################################")

dk_depend(emsdk)
dk_depend(make)

set(CMAKE_TOOLCHAIN_FILE 						${EMSCRIPTEN_TOOLCHAIN_FILE})	
dk_append(CMAKE_C_FLAGS							-DEMSCRIPTEN -std=gnu11)
dk_append(CMAKE_CXX_FLAGS						-DEMSCRIPTEN -std=gnu++17)
dk_append(DKCONFIGURE_CFLAGS					-DEMSCRIPTEN -std=gnu11)
dk_append(DKCONFIGURE_CXXFLAGS					-DEMSCRIPTEN -std=gnu++17)
dk_append(DKCMAKE_FLAGS							-DEMSCRIPTEN=1)
#dk_append(CMAKE_EXE_LINKER_FLAGS				-static) # -s)