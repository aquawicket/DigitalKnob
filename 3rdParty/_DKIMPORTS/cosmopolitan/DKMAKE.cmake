#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


########### cosmopolitan ############
# https://github.com/jart/cosmopolitan.git


### IMPORT ###
dk_import(https://github.com/jart/cosmopolitan/archive/e4d6eb3.zip)


#dk_set(COSMOPOLITAN 							1)
##dk_set(COSMOPOLITAN_SYSTEM_NAME 				Generic)
#dk_set(COSMOPOLITAN_SKIP_RPATH 				ON)
#dk_set(COSMOPOLITAN_CROSSCOMPILING 			OFF)

#dk_validate(host_triple "dk_host_triple()")
#if(WIN_HOST)
#	dk_set(COSMOPOLITAN_GENERATOR				"MSYS Makefiles")
#else()
#	dk_set(COSMOPOLITAN_GENERATOR				"Unix Makefiles")
#endif()
#dk_set(COSMOPOLITAN_FORCE_UNIX_PATHS 			1)

#dk_set(COSMOPOLITAN_MAKE_PROGRAM 				"${COSMOPOLITAN}/tool/cosmocc/bin/make")
#dk_set(COSMOPOLITAN_AR 						"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoar")
dk_set(COSMOPOLITAN_C_COMPILER 					"${COSMOPOLITAN}/tool/cosmocc/bin/cosmocc")
dk_set(COSMOPOLITAN_CXX_COMPILER 				"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoc++")
#dk_set(COSMOPOLITAN_C_COMPILER 				"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-cc")
#dk_set(COSMOPOLITAN_CXX_COMPILER 				"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-c++")
#dk_set(COSMOPOLITAN_??			 				"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-addr2line")
#dk_set(COSMOPOLITAN_AR 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-ar")
#dk_set(COSMOPOLITAN_?? 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-as")
#dk_set(COSMOPOLITAN_?? 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-c++filt")
#dk_set(COSMOPOLITAN_?? 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-install")
#dk_set(COSMOPOLITAN_?? 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-nm")
#dk_set(COSMOPOLITAN_?? 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-objcopy")
#dk_set(COSMOPOLITAN_?? 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-objdump")
#dk_set(COSMOPOLITAN_?? 						"${COSMOPOLITAN}/tool/cosmocc/bin/x86_64-unknown-cosmo-readelf")
#dk_set(COSMOPOLITAN_ASM_COMPILER 				"${COSMOPOLITAN_C_COMPILER}")

dk_set(COSMOPOLITAN_RANLIB 						"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib")
dk_set(COSMOPOLITAN_LINKER 						"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld")
#foreach(lang ASM C CXX)
#  dk_set(COSMOPOLITAN_${lang}_COMPILER_AR 		"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
#  dk_set(COSMOPOLITAN_${lang}_COMPILER_RANLIB 	"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
#endforeach()

dk_set(COSMOPOLITAN_ASM_COMPILER_AR 					"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
dk_set(COSMOPOLITAN_C_COMPILER_AR 						"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
dk_set(COSMOPOLITAN_CXX_COMPILER_AR 					"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
dk_set(COSMOPOLITAN_ASM_COMPILER_RANLIB				"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
dk_set(COSMOPOLITAN_C_COMPILER_RANLIB 					"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
dk_set(COSMOPOLITAN_CXX_COMPILER_RANLIB				"${COSMOPOLITAN}/tool/cosmocc/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")


#dk_set(CMAKE_C_COMPILER_WORKS           		1)
#dk_set(CMAKE_CXX_COMPILER_WORKS         		1)
#dk_set(CMAKE_CXX_FLAGS_INIT 					-fexceptions -frtti)
#dk_validate(DKIMPORTS_DIR						"dk_DKIMPORTS_DIR()")
#dk_set(CMAKE_USER_MAKE_RULES_OVERRIDE 			${DKIMPORTS_DIR}/cosmocc/cosmo_user_make_rules_override.cmake)
#dk_set(CMAKE_ASM_OUTPUT_EXTENSION 				.o)
#dk_set(CMAKE_C_OUTPUT_EXTENSION   				.o)
#dk_set(CMAKE_CXX_OUTPUT_EXTENSION 				.o)
#dk_set(CMAKE_LINK_LIBRARY_SUFFIX				.a)
#dk_set(CMAKE_LINK_LIBRARY_PREFIX	   			lib)
#dk_set(CMAKE_C_LINK_LIBRARY_SUFFIX				.a)
#dk_set(CMAKE_C_LINK_LIBRARY_PREFIX	   			lib)
#dk_set(CMAKE_CXX_LINK_LIBRARY_SUFFIX			.a)
#dk_set(CMAKE_CXX_LINK_LIBRARY_PREFIX   		lib)
#dk_set(CMAKE_IMPORT_LIBRARY_SUFFIX      		.a)
#dk_set(CMAKE_IMPORT_LIBRARY_PREFIX     		lib)


###### set GLOBAL CMAKE VARIABLES ######
#if(NOT CMAKE_C_COMPILER)
#	dk_set(CMAKE_C_COMPILER						${COSMOPOLITAN_C_COMPILER})
#endif()
#if(NOT CMAKE_CXX_COMPILER)
#	dk_set(CMAKE_CXX_COMPILER					${COSMOPOLITAN_CXX_COMPILER})
#ndif()
#if(NOT CMAKE_MAKE_PROGRAM)
#	dk_set(CMAKE_MAKE_PROGRAM					${COSMOPOLITAN_MAKE_PROGRAM})
#endif()
#if(NOT CMAKE_ASM_COMPILER)
#	dk_set(CMAKE_ASM_COMPILER					${COSMOPOLITAN_ASM_COMPILER})
#endif()
#if(NOT CMAKE_AR)
#	dk_set(CMAKE_AR								${COSMOPOLITAN_AR})
#endif()
#if(NOT CMAKE_RANLIB)
#	dk_set(CMAKE_RANLIB							${COSMOPOLITAN_RANLIB})
#endif()
#if(NOT CMAKE_LINKER)
#	dk_set(CMAKE_LINKER							${COSMOPOLITAN_LINKER})
#endif()
#foreach(lang ASM C CXX)
#	if(NOT CMAKE_${lang}_COMPILER_AR)
#		dk_set(CMAKE_${lang}_COMPILER_AR 		${COSMOPOLITAN_${lang}_COMPILER_AR})
#	endif()
#	if(NOT CMAKE_${lang}_COMPILER_RANLIB)
#		dk_set(CMAKE_${lang}_COMPILER_RANLIB 	${COSMOPOLITAN_${lang}_COMPILER_RANLIB})
#	endif()
#endforeach()


#dk_set(DKCONFIGURE_CC							${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX							${CMAKE_CXX_COMPILER})

#dk_set(COSMOPOLITAN_BIN						"export PATH=${COSMOPOLITAN}/tool/cosmocc/bin:$PATH")
