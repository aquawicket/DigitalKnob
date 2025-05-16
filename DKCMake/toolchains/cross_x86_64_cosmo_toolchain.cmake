message("############################################################################")
message("################## cross_x86_64_cosmo_toolchain.cmake ######################")
message("############################################################################")

dk_depend(Cosmopolitan)
#dk_depend(make)

#dk_set(CMAKE_SYSTEM_NAME 					Generic)
dk_set(Cosmopolitan 						1)
set(CMAKE_SKIP_RPATH 						ON)
set(CMAKE_CROSSCOMPILING 					OFF)

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Win_Host)
	set(CMAKE_GENERATOR						"MSYS Makefiles")
else()
	set(CMAKE_GENERATOR						"Unix Makefiles")
endif()
set(CMAKE_FORCE_UNIX_PATHS 1)
dk_append(CMAKE_C_FLAGS						-DCOSMOPOLITAN)# -std=gnu17)   # -D_CRT_SECURE_NO_WARNINGS 
dk_append(CMAKE_CXX_FLAGS					-DCOSMOPOLITAN)# -std=gnu++17) # -D_CRT_SECURE_NO_WARNINGS
dk_append(CMAKE_EXE_LINKER_FLAGS			-static) # -s)

#dk_append(DKCONFIGURE_FLAGS				--build=x86_64-w64)
#dk_set(DKCONFIGURE_CC						${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX						${CMAKE_CXX_COMPILER})
#dk_append(DKCONFIGURE_CFLAGS				${CMAKE_C_FLAGS})
#dk_append(DKCONFIGURE_CXXFLAGS				${CMAKE_CXX_FLAGS})

dk_validate(ENV{DKIMPORTS_DIR}					"dk_DKIMPORTS_DIR()")
dk_append(DKCMAKE_FLAGS
	-DCMAKE_USER_MAKE_RULES_OVERRIDE=$ENV{DKIMPORTS_DIR}/Cosmopolitan/cosmo_user_make_rules_override.cmake
	-DCMAKE_C_COMPILER_WORKS=1
	-DCMAKE_CXX_COMPILER_WORKS=1)
set(CMAKE_C_COMPILER_WORKS					1)
set(CMAKE_CXX_COMPILER_WORKS        		1)
set(CMAKE_CXX_FLAGS_INIT 					-fexceptions -frtti)
set(CMAKE_USER_MAKE_RULES_OVERRIDE 			$ENV{DKIMPORTS_DIR}/Cosmopolitan/cosmo_user_make_rules_override.cmake)
set(CMAKE_ASM_OUTPUT_EXTENSION 				.o)
set(CMAKE_C_OUTPUT_EXTENSION   				.o)
set(CMAKE_CXX_OUTPUT_EXTENSION 				.o)
set(CMAKE_LINK_LIBRARY_SUFFIX				.a)
set(CMAKE_LINK_LIBRARY_PREFIX	   			lib)
set(CMAKE_C_LINK_LIBRARY_SUFFIX				.a)
set(CMAKE_C_LINK_LIBRARY_PREFIX	   			lib)
set(CMAKE_CXX_LINK_LIBRARY_SUFFIX			.a)
set(CMAKE_CXX_LINK_LIBRARY_PREFIX   		lib)
set(CMAKE_IMPORT_LIBRARY_SUFFIX      		.a)
set(CMAKE_IMPORT_LIBRARY_PREFIX     		lib)

###### set CMAKE VARIABLES ######
set(CMAKE_MAKE_PROGRAM						${COSMOPOLITAN_MAKE_PROGRAM})
set(CMAKE_C_COMPILER						${COSMOPOLITAN_C_COMPILER})
set(CMAKE_CXX_COMPILER						${COSMOPOLITAN_CXX_COMPILER})
set(CMAKE_ASM_COMPILER						${COSMOPOLITAN_ASM_COMPILER})
set(CMAKE_AR								${COSMOPOLITAN_AR})
set(CMAKE_RANLIB							${COSMOPOLITAN_RANLIB})
set(CMAKE_LINKER							${COSMOPOLITAN_LINKER})
foreach(lang ASM C CXX)
	if(NOT CMAKE_${lang}_COMPILER_AR)
		set(CMAKE_${lang}_COMPILER_AR 		${COSMOPOLITAN_${lang}_COMPILER_AR})
	endif()
	if(NOT CMAKE_${lang}_COMPILER_RANLIB)
		set(CMAKE_${lang}_COMPILER_RANLIB 	${COSMOPOLITAN_${lang}_COMPILER_RANLIB})
	endif()
endforeach()


############ Cosmopolitan BASH EXPORTS ############
dk_set(COSMOPOLITAN_BIN						"export PATH=${Cosmopolitan}/tool/cosmocc/bin:$PATH")