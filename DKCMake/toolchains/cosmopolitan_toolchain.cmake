message("######################################################################")
message("################## cosmopolitan_toolchain.cmake ######################")
message("######################################################################")

dk_depend(cosmopolitan)
#dk_depend(make)

#dk_set(COSMOPOLITAN 						1)
#dk_set(CMAKE_SYSTEM_NAME 					Generic)
dk_set(CMAKE_SKIP_RPATH 					ON)
dk_set(CMAKE_CROSSCOMPILING 				OFF)

dk_validate(MSYS2 "dk_depend(msys2)")
dk_prependEnvPath("${MSYS2}/usr/bin")

dk_validate(COSMOCC "dk_depend(cosmocc)")
dk_prependEnvPath("${COSMOCC}/bin")

dk_prependEnvPath("${COSMOPOLITAN}/tool/cosmocc/bin")

dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_set(CMAKE_GENERATOR					"MSYS Makefiles")
else()
	dk_set(CMAKE_GENERATOR					"Unix Makefiles")
endif()
set(CMAKE_FORCE_UNIX_PATHS 1)
dk_append(CMAKE_C_FLAGS						-DCOSMOPOLITAN)# -std=gnu17)   # -D_CRT_SECURE_NO_WARNINGS 
dk_append(CMAKE_CXX_FLAGS					-DCOSMOPOLITAN)# -std=gnu++17) # -D_CRT_SECURE_NO_WARNINGS
dk_append(CMAKE_EXE_LINKER_FLAGS			-static) # -s)

dk_validate(DKIMPORTS_DIR					"dk_DKIMPORTS_DIR()")
dk_append(DKCMAKE_FLAGS
	-DCMAKE_USER_MAKE_RULES_OVERRIDE=${DKIMPORTS_DIR}/COSMOPOLITAN/cosmopolitan_user_make_rules_override.cmake
	-DCMAKE_C_COMPILER_WORKS=1
	-DCMAKE_CXX_COMPILER_WORKS=1)
	
dk_set(CMAKE_AR								"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoar")
dk_set(CMAKE_ASM_COMPILER					"${COSMOPOLITAN}/tool/cosmocc/bin/cosmocc")
dk_set(CMAKE_ASM_COMPILER_AR				"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoar")
dk_set(CMAKE_ASM_COMPILER_RANLIB			"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoranlib")
dk_set(CMAKE_ASM_OUTPUT_EXTENSION 			.o)
dk_set(CMAKE_CXX_COMPILER					"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoc++")
dk_set(CMAKE_CXX_COMPILER_AR				"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoar")
dk_set(CMAKE_CXX_COMPILER_RANLIB			"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoranlib")
dk_set(CMAKE_CXX_COMPILER_WORKS        		1)
dk_set(CMAKE_CXX_FLAGS_INIT 				-fexceptions -frtti)
dk_set(CMAKE_CXX_OUTPUT_EXTENSION 			.o)
dk_set(CMAKE_C_COMPILER						"${COSMOPOLITAN}/tool/cosmocc/bin/cosmocc")
dk_set(CMAKE_C_COMPILER_AR					"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoar")
dk_set(CMAKE_C_COMPILER_RANLIB				"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoranlib")
dk_set(CMAKE_C_COMPILER_WORKS				1)
dk_set(CMAKE_C_OUTPUT_EXTENSION   			.o)
#dk_set(CMAKE_LINKER						)
#dk_set(CMAKE_MAKE_PROGRAM					)
dk_set(CMAKE_RANLIB							"${COSMOPOLITAN}/tool/cosmocc/bin/cosmoranlib")
dk_set(CMAKE_USER_MAKE_RULES_OVERRIDE 		"${DKIMPORTS_DIR}/cosmopolitan/cosmopolitan_user_make_rules_override.cmake")



dk_set(DKCONFIGURE_CC						${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX						${CMAKE_CXX_COMPILER})
dk_append(DKCONFIGURE_FLAGS					--build=x86_64-w64)
dk_append(DKCONFIGURE_CFLAGS				${CMAKE_C_FLAGS})
dk_append(DKCONFIGURE_CXXFLAGS				${CMAKE_CXX_FLAGS})
