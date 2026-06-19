#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ cosmocc ############
# https://cosmo.zip
# https://cosmo.zip/pub/cosmocc/cosmocc.zip

dk_import()

#dk_set(COSMO		 							1)
#dk_set(COSMOPOLITAN 							1)

################## cosmocc Variables ##################
#dk_set(CMAKE_SYSTEM_NAME 					Generic)
#dk_set(CMAKE_SKIP_RPATH 						ON)
#dk_set(CMAKE_CROSSCOMPILING 					OFF)
#if(Windows_Host)
#	dk_set(CMAKE_GENERATOR					"MSYS Makefiles")
#else()
#	dk_set(CMAKE_GENERATOR					"Unix Makefiles")
#endif()
#dk_set(CMAKE_ADDR2LINE	 					"${cosmocc}/bin/x86_64-unknown-cosmo-addr2line")
#dk_set(CMAKE_AR 							"${cosmocc}/bin/cosmoar")
#dk_set(CMAKE_AS 							"${cosmocc}/bin/x86_64-unknown-cosmo-as")
#dk_set(CMAKE_ASM_COMPILER 					"${cosmocc}/bin/cosmocc")
#dk_set(CMAKE_ASM_COMPILER_AR 				"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
#dk_set(CMAKE_ASM_COMPILER_RANLIB 			"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
#dk_set(CMAKE_ASM_OUTPUT_EXTENSION 			.o)
#dk_set(CMAKE_BIN							"${cosmocc}/bin")
#dk_set(CMAKE_CXXFILT						"${cosmocc}/bin/x86_64-unknown-cosmo-c++filt")
dk_set(CMAKE_CXX_COMPILER 					"${cosmocc}/bin/cosmoc++")
#dk_set(CMAKE_CXX_COMPILER 					"${cosmocc}/bin/x86_64-unknown-cosmo-c++")
#dk_set(CMAKE_CXX_COMPILER_AR 				"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
#dk_set(CMAKE_CXX_COMPILER_RANLIB 			"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
#dk_set(CMAKE_CXX_COMPILER_WORKS        	1)
#dk_set(CMAKE_CXX_FLAGS_INIT				-fexceptions -frtti)
#dk_set(CMAKE_CXX_OUTPUT_EXTENSION 			.o)
dk_set(CMAKE_C_COMPILER 					"${cosmocc}/bin/cosmocc")
#dk_set(CMAKE_C_COMPILER 					"${cosmocc}/bin/x86_64-unknown-cosmo-cc")
#dk_set(CMAKE_C_COMPILER_AR 				"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
#dk_set(CMAKE_C_COMPILER_RANLIB 			"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
#dk_set(CMAKE_C_COMPILER_WORKS          	1)
#dk_set(CMAKE_C_OUTPUT_EXTENSION   			.o)
#dk_set(CMAKE_FORCE_UNIX_PATHS 				1)
#dk_set(CMAKE_INSTALL						"${cosmocc}/bin/x86_64-unknown-cosmo-install")
#dk_set(CMAKE_LINKER 						"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld")
#dk_set(CMAKE_MAKE_PROGRAM 					"${cosmocc}/bin/make")
#dk_set(CMAKE_NM 							"${cosmocc}/bin/x86_64-unknown-cosmo-nm")
#dk_set(CMAKE_OBJCOPY						"${cosmocc}/bin/x86_64-unknown-cosmo-objcopy")
#dk_set(CMAKE_OBJDUMP						"${cosmocc}/bin/x86_64-unknown-cosmo-objdump")
#dk_set(CMAKE_RANLIB 						"${cosmocc}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib")
#dk_set(CMAKE_READELF						"${cosmocc}/bin/x86_64-unknown-cosmo-readelf")
#dk_set(CMAKE_USER_MAKE_RULES_OVERRIDE		"${DKIMPORTS_DIR}/cosmocc/cosmocc_user_make_rules_override.cmake")



############ DKCONFIGURE variables ############
#dk_set(DKCONFIGURE_CC						"${cosmocc}/bin/cosmocc")
#dk_set(DKCONFIGURE_CXX						"${cosmocc}/bin/cosmoc++")


