include_guard()
	
set(CLANG64_DIR "C:/Users/aquawicket/digitalknob/Development/3rdParty/msys2-x86_64-20231026/clang64")
set(CMAKE_MAKE_PROGRAM ${CLANG64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANG64_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANG64_DIR}/bin/clang++.exe)
