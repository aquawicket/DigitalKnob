set(CMAKE_SYSTEM_NAME Generic)

set(COSMOPOLITAN 1)
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_SKIP_RPATH ON)
set(CMAKE_CROSSCOMPILING OFF)

set(COSMOCPP_BIN_DIR				"C:/Users/Administrator/digitalknob/Development/3rdParty/cosmocc-master/bin" 									CACHE INTERNAL "")
set(CMAKE_MAKE_PROGRAM 				"C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin/mingw32-make.exe" 	CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER 				"${COSMOCPP_BIN_DIR}/cosmocc" 																					CACHE INTERNAL "")
set(CMAKE_C_COMPILER 				"${COSMOCPP_BIN_DIR}/cosmocc" 																					CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER 				"${COSMOCPP_BIN_DIR}/cosmoc++" 																					CACHE INTERNAL "")
set(CMAKE_AR 						"${COSMOCPP_BIN_DIR}/cosmoar" 																					CACHE INTERNAL "")
set(CMAKE_RANLIB 					"${COSMOCPP_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib"											CACHE INTERNAL "")
set(CMAKE_LINKER 					"${COSMOCPP_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld"												CACHE INTERNAL "")
foreach(lang ASM C CXX)
  set(CMAKE_${lang}_COMPILER_AR 	"${COSMOCPP_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar" 										CACHE INTERNAL "")
  set(CMAKE_${lang}_COMPILER_RANLIB "${COSMOCPP_BIN_DIR}/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib" 									CACHE INTERNAL "")
endforeach()


set(CMAKE_CXX_FLAGS_INIT "-fexceptions -frtti")

set(CMAKE_USER_MAKE_RULES_OVERRIDE "${COSMOCPP_BIN_DIR}/cosmo_user_make_rules_override.cmake")
