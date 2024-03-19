include_guard()
	
set(CLANG32_DIR "C:/Users/aquawicket/digitalknob/Development/3rdParty/msys2-x86_64-20231026/clang32")
set(CMAKE_MAKE_PROGRAM ${CLANG32_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANG32_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANG32_DIR}/bin/clang++.exe)
