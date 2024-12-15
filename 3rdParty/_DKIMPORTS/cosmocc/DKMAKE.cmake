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

dk_import(https://cosmo.zip/pub/cosmocc/cosmocc.zip)

#dk_set(COSMO		 							1)
#dk_set(COSMOPOLITAN 							1)

#dk_validate(host_triple 						"dk_host_triple()")
#dk_validate(DKIMPORTS_DIR						"dk_DKIMPORTS_DIR()")
################## COSMOCC Variables ##################
#dk_set(COSMOCC_SYSTEM_NAME 					Generic)
#dk_set(COSMOCC_SKIP_RPATH 						ON)
#dk_set(COSMOCC_CROSSCOMPILING 					OFF)
#if(WIN_HOST)
#	dk_set(COSMOCC_GENERATOR					"MSYS Makefiles")
#else()
#	dk_set(COSMOCC_GENERATOR					"Unix Makefiles")
#endif()
#dk_set(COSMOCC_ADDR2LINE	 					"${COSMOCC}/bin/x86_64-unknown-cosmo-addr2line")
#dk_set(COSMOCC_AR 								"${COSMOCC}/bin/cosmoar")
#dk_set(COSMOCC_AS 								"${COSMOCC}/bin/x86_64-unknown-cosmo-as")
#dk_set(COSMOCC_ASM_COMPILER 					"${COSMOCC}/bin/cosmocc")
#dk_set(COSMOCC_ASM_COMPILER_AR 				"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
#dk_set(COSMOCC_ASM_COMPILER_RANLIB 			"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
#dk_set(COSMOCC_ASM_OUTPUT_EXTENSION 			.o)
#dk_set(COSMOCC_BIN								"${COSMOCC}/bin")
#dk_set(COSMOCC_CXXFILT							"${COSMOCC}/bin/x86_64-unknown-cosmo-c++filt")
#dk_set(COSMOCC_CXX_COMPILER 					"${COSMOCC}/bin/cosmoc++")
#dk_set(COSMOCC_CXX_COMPILER 					"${COSMOCC}/bin/x86_64-unknown-cosmo-c++")
#dk_set(COSMOCC_CXX_COMPILER_AR 				"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
#dk_set(COSMOCC_CXX_COMPILER_RANLIB 			"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
#dk_set(COSMOCC_CXX_COMPILER_WORKS        		1)
#dk_set(COSMOCC_CXX_FLAGS_INIT					-fexceptions -frtti)
#dk_set(COSMOCC_CXX_OUTPUT_EXTENSION 			.o)
#dk_set(COSMOCC_C_COMPILER 						"${COSMOCC}/bin/cosmocc")
#dk_set(COSMOCC_C_COMPILER 						"${COSMOCC}/bin/x86_64-unknown-cosmo-cc")
#dk_set(COSMOCC_C_COMPILER_AR 					"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar")
#dk_set(COSMOCC_C_COMPILER_RANLIB 				"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib")
#dk_set(COSMOCC_C_COMPILER_WORKS          		1)
#dk_set(COSMOCC_C_OUTPUT_EXTENSION   			.o)
#dk_set(COSMOCC_FORCE_UNIX_PATHS 				1)
#dk_set(COSMOCC_INSTALL							"${COSMOCC}/bin/x86_64-unknown-cosmo-install")
#dk_set(COSMOCC_LINKER 							"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld")
#dk_set(COSMOCC_MAKE_PROGRAM 					"${COSMOCC}/bin/make")
#dk_set(COSMOCC_NM 								"${COSMOCC}/bin/x86_64-unknown-cosmo-nm")
#dk_set(COSMOCC_OBJCOPY							"${COSMOCC}/bin/x86_64-unknown-cosmo-objcopy")
#dk_set(COSMOCC_OBJDUMP							"${COSMOCC}/bin/x86_64-unknown-cosmo-objdump")
#dk_set(COSMOCC_RANLIB 							"${COSMOCC}/bin/${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib")
#dk_set(COSMOCC_READELF							"${COSMOCC}/bin/x86_64-unknown-cosmo-readelf")
#dk_set(COSMOCC_USER_MAKE_RULES_OVERRIDE		"${DKIMPORTS_DIR}/cosmocc/cosmocc_user_make_rules_override.cmake")




############ CMAKE Compiler variables ############
#dk_set(CMAKE_AR								${COSMOCC_AR})
#dk_set(CMAKE_ASM_COMPILER						${COSMOCC_ASM_COMPILER})
#dk_set(CMAKE_ASM_COMPILER_AR 					${COSMOCC_ASM_COMPILER_AR})
#dk_set(CMAKE_ASM_COMPILER_RANLIB 				${COSMOCC_ASM_COMPILER_RANLIB})
#dk_set(CMAKE_ASM_OUTPUT_EXTENSION 				${COSMOCC_ASM_OUTPUT_EXTENSION})
#dk_set(CMAKE_CXX_COMPILER						${COSMOCC_CXX_COMPILER})
#dk_set(CMAKE_CXX_COMPILER_AR 					${COSMOCC_CXX_COMPILER_AR})
#dk_set(CMAKE_CXX_COMPILER_RANLIB 				${COSMOCC_CXX_COMPILER_RANLIB})
#dk_set(CMAKE_CXX_COMPILER_WORKS        		${COSMOCC_CXX_COMPILER_WORKS})
#dk_set(CMAKE_CXX_FLAGS_INIT 					${COSMOCC_CXX_FLAGS_INIT})
#dk_set(CMAKE_CXX_OUTPUT_EXTENSION 				${COSMOCC_CXX_OUTPUT_EXTENSION})
#dk_set(CMAKE_C_COMPILER						${COSMOCC_C_COMPILER})
#dk_set(CMAKE_C_COMPILER_AR 					${COSMOCC_C_COMPILER_AR})
#dk_set(CMAKE_C_COMPILER_RANLIB 				${COSMOCC_C_COMPILER_RANLIB})
#dk_set(CMAKE_C_COMPILER_WORKS          		${COSMOCC_C_COMPILER_WORKS})
#dk_set(CMAKE_C_OUTPUT_EXTENSION   				${COSMOCC_C_OUTPUT_EXTENSION})
#dk_set(CMAKE_LINKER							${COSMOCC_LINKER})
#dk_set(CMAKE_MAKE_PROGRAM						${COSMOCC_MAKE_PROGRAM})
#dk_set(CMAKE_RANLIB							${COSMOCC_RANLIB})
#dk_set(CMAKE_USER_MAKE_RULES_OVERRIDE 			${COSMOCC_USER_MAKE_RULES_OVERRIDE})

############ DKCONFIGURE variables ############
#dk_set(DKCONFIGURE_CC							${COSMOCC_C_COMPILER})
#dk_set(DKCONFIGURE_CXX							${COSMOCC_CXX_COMPILER})


