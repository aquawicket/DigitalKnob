#!/usr/bin/cmake -P
include_guard()
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/) # From this path to DK.cmake
endif()
if(NOT EXISTS ${DKCMAKE_FUNCTIONS_DIR_})
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../../../../../DKCMake/functions/) # From try compile to Dk.cmake 
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

###### [cosmocc] ######
# https://cosmo.zip

dk_load(dk_builder)

dk_import(https://cosmo.zip/pub/cosmocc/cosmocc.zip)


#dk_set(CMAKE_SYSTEM_NAME 				Generic)
dk_set(COSMO		 					1)
dk_set(COSMOPOLITAN 					1)
dk_set(CMAKE_SKIP_RPATH 				ON)
dk_set(CMAKE_CROSSCOMPILING 			OFF)

if(WIN_HOST)
	dk_set(CMAKE_GENERATOR				"MSYS Makefiles")
else()
	dk_set(CMAKE_GENERATOR				"Unix Makefiles")
endif()
dk_set(CMAKE_FORCE_UNIX_PATHS 1)

#dk_validate(MSYS2 						"include(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)")
dk_validate(MSYS2 						"dk_depend(msys2)")
dk_set(COSMO_MAKE_PROGRAM 				"${MSYS2}/clang64/bin/mingw32-make.exe")
dk_set(COSMO_ASM_COMPILER 				"${COSMOCC}/bin/cosmocc")
dk_set(COSMO_C_COMPILER 				"${COSMOCC}/bin/cosmocc")
dk_set(COSMO_CXX_COMPILER 				"${COSMOCC}/bin/cosmoc++")
dk_set(COSMO_AR 						"${COSMOCC}/bin/cosmoar")
dk_set(COSMO_RANLIB 					"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib")
dk_set(COSMO_LINKER 					"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld")
foreach(lang ASM C CXX)
  dk_set(COSMO_${lang}_COMPILER_AR 		"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
  dk_set(COSMO_${lang}_COMPILER_RANLIB 	"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
endforeach()


dk_set(CMAKE_C_COMPILER_WORKS           1)
dk_set(CMAKE_CXX_COMPILER_WORKS         1)
dk_set(CMAKE_CXX_FLAGS_INIT 			-fexceptions -frtti)
dk_validate(DKIMPORTS_DIR				"dk_DKIMPORTS_DIR()")
dk_set(CMAKE_USER_MAKE_RULES_OVERRIDE 	${DKIMPORTS_DIR}/cosmocc/cosmo_toolchain.cmake)
dk_set(CMAKE_ASM_OUTPUT_EXTENSION 		.o)
dk_set(CMAKE_C_OUTPUT_EXTENSION 		.o)
dk_set(CMAKE_CXX_OUTPUT_EXTENSION 		.o)



###### set GLOBAL CMAKE VARIABLES ######
if(NOT CMAKE_C_COMPILER)
	dk_set(CMAKE_C_COMPILER						${COSMO_C_COMPILER})
endif()
if(NOT CMAKE_CXX_COMPILER)
	dk_set(CMAKE_CXX_COMPILER					${COSMO_CXX_COMPILER})
endif()
if(NOT CMAKE_MAKE_PROGRAM)
	dk_set(CMAKE_MAKE_PROGRAM					${COSMO_MAKE_PROGRAM})
endif()
if(NOT CMAKE_ASM_COMPILER)
	dk_set(CMAKE_ASM_COMPILER					${COSMO_ASM_COMPILER})
endif()
if(NOT CMAKE_AR)
	dk_set(CMAKE_AR								${COSMO_AR})
endif()
if(NOT CMAKE_RANLIB)
	dk_set(CMAKE_RANLIB							${COSMO_RANLIB})
endif()
if(NOT CMAKE_LINKER)
	dk_set(CMAKE_LINKER							${COSMO_LINKER})
endif()
foreach(lang ASM C CXX)
	if(NOT CMAKE_${lang}_COMPILER_AR)
		dk_set(CMAKE_${lang}_COMPILER_AR 		${COSMO_${lang}_COMPILER_AR})
	endif()
	if(NOT CMAKE_${lang}_COMPILER_RANLIB)
		dk_set(CMAKE_${lang}_COMPILER_RANLIB 	${COSMO_${lang}_COMPILER_RANLIB})
	endif()
endforeach()


dk_set(DKCONFIGURE_CC							${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX							${CMAKE_CXX_COMPILER})

dk_set(COSMO_BASH_EXPORTS						"export PATH=${COSMOCC}/bin:$PATH")
