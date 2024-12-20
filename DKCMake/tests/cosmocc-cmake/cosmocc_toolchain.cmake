set(CMAKE_SYSTEM_NAME Generic)

set(COSMOPOLITAN 1)
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_SKIP_RPATH ON)
set(CMAKE_CROSSCOMPILING OFF)

set(COSMOCC_BIN_DIR					"C:/Users/Administrator/digitalknob/Development/3rdParty/cosmocc-master/bin" 									CACHE INTERNAL "")
set(CMAKE_MAKE_PROGRAM 				"C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin/mingw32-make.exe" 	CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER 				"${COSMOCC_BIN_DIR}/cosmocc" 																					CACHE INTERNAL "")
set(CMAKE_C_COMPILER 				"${COSMOCC_BIN_DIR}/cosmocc" 																					CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER 				"${COSMOCC_BIN_DIR}/cosmoc++" 																					CACHE INTERNAL "")
set(CMAKE_AR 						"${COSMOCC_BIN_DIR}/cosmoar" 																					CACHE INTERNAL "")
set(CMAKE_RANLIB 					"${COSMOCC_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib"											CACHE INTERNAL "")
set(CMAKE_LINKER 					"${COSMOCC_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld"												CACHE INTERNAL "")
foreach(lang ASM C CXX)
  set(CMAKE_${lang}_COMPILER_AR 	"${COSMOCC_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar" 											CACHE INTERNAL "")
  set(CMAKE_${lang}_COMPILER_RANLIB "${COSMOCC_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib" 										CACHE INTERNAL "")
endforeach()


set(CMAKE_CXX_FLAGS_INIT "-fexceptions -frtti")

set(CMAKE_USER_MAKE_RULES_OVERRIDE ${CMAKE_CURRENT_LIST_FILE})
set(CMAKE_ASM_OUTPUT_EXTENSION .o)
set(CMAKE_C_OUTPUT_EXTENSION .o)
set(CMAKE_CXX_OUTPUT_EXTENSION .o)

