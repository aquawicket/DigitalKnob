set(CMAKE_SYSTEM_NAME Generic)

#et(Cosmopolitan 1)
#set(BUILD_SHARED_LIBS OFF)
#set(CMAKE_SKIP_RPATH ON)
#set(CMAKE_CROSSCOMPILING OFF)

set(DK3RDPARTY_DIR					"$ENV{SystemDrive}/Users/Administrator/digitalknob/Development/3rdParty"											CACHE INTERNAL "")	
set(CMAKE_USER_MAKE_RULES_OVERRIDE 	"$ENV{DK3RDPARTY_DIR}/_DKIMPORTS/cosmopolitan/cosmopolitan_user_make_rules_override.cmake"							CACHE INTERNAL "")
set(CMAKE_MAKE_PROGRAM 				"$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20240727/clang64/bin/mingw32-make.exe" 											CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER 				"$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/cosmocc"												CACHE INTERNAL "")
set(CMAKE_C_COMPILER 				"$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/cosmocc"												CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER 				"$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/cosmoc++" 												CACHE INTERNAL "")
set(CMAKE_AR 						"$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/cosmoar" 												CACHE INTERNAL "")
set(CMAKE_RANLIB 					"$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib"		CACHE INTERNAL "")
set(CMAKE_LINKER 					"$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld"			CACHE INTERNAL "")
foreach(lang ASM C CXX)
  set(CMAKE_${lang}_COMPILER_AR 	"$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar" 		CACHE INTERNAL "")
  set(CMAKE_${lang}_COMPILER_RANLIB "$ENV{DK3RDPARTY_DIR}/cosmopolitan-e4d6eb3/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib" 	CACHE INTERNAL "")
endforeach()

set(CMAKE_CXX_FLAGS_INIT "-fexceptions -frtti")


