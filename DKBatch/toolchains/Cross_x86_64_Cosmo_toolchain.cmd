%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################## Cross_x86_64_Cosmo_toolchain.cmd ########################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_prependArgs CMAKE_ARGS -DCOSMOPOLITAN=1
set CMAKE_GENERATOR="MSYS Makefiles"








rem %dk_call% dk_depend cosmopolitan
rem %dk_call% dk_depend make
rem %dk_call% dk_set CMAKE_SYSTEM_NAME 						"Generic"
rem %dk_call% dk_set Cosmopolitan 							1
rem %dk_call% dk_set CMAKE_SKIP_RPATH 						"ON"
rem %dk_call% dk_set CMAKE_CROSSCOMPILING 					"OFF"
rem %dk_call% dk_validate Host_Tuple "dk_Host_Tuple"
rem if defined Windows_Host (
rem 	%dk_call% dk_set CMAKE_GENERATOR					"MSYS Makefiles"
rem ) else (	
rem 	%dk_call% dk_set CMAKE_GENERATOR					"Unix Makefiles"
rem )
rem  %dk_call% dk_set CMAKE_FORCE_UNIX_PATHS 				1
rem  %dk_call% dk_append CMAKE_C_FLAGS						-DCOSMOPOLITAN)# -std=gnu17)   # -D_CRT_SECURE_NO_WARNINGS
rem  %dk_call% dk_append CMAKE_CXX_FLAGS					-DCOSMOPOLITAN)# -std=gnu++17) # -D_CRT_SECURE_NO_WARNINGS
rem  %dk_call% dk_append cmake_exe_LINKER_FLAGS				"-static"  &rem  -s)
rem  %dk_call% dk_append DKCONFIGURE_FLAGS					"--build=x86_64-w64"
rem  %dk_call% dk_set DKCONFIGURE_CC						"%CMAKE_C_COMPILER%"
rem  %dk_call% dk_set DKCONFIGURE_CXX						"%CMAKE_CXX_COMPILER%"
rem  %dk_call% dk_append DKCONFIGURE_CFLAGS					"%CMAKE_C_FLAGS%"
rem  %dk_call% dk_append DKCONFIGURE_CXXFLAGS				"%CMAKE_CXX_FLAGS%"
rem %dk_call% dk_validate %DKIMPORTS_DIR%					"dk_DKIMPORTS_DIR"
rem %dk_call% dk_append DKCMAKE_FLAGS
rem	-DCMAKE_USER_MAKE_RULES_OVERRIDE=$%DKIMPORTS_DIR%/Cosmopolitan/cosmo_user_make_rules_override.cmd
rem	-DCMAKE_C_COMPILER_WORKS=1
rem	-DCMAKE_CXX_COMPILER_WORKS=1
rem %dk_call% dk_set CMAKE_C_COMPILER_WORKS					1
rem %dk_call% dk_set CMAKE_CXX_COMPILER_WORKS       	 	1
rem %dk_call% dk_set CMAKE_CXX_FLAGS_INIT 					-fexceptions -frtti
rem %dk_call% dk_set CMAKE_USER_MAKE_RULES_OVERRIDE 		$%DKIMPORTS_DIR%/Cosmopolitan/cosmo_user_make_rules_override.cmd
rem %dk_call% dk_set CMAKE_ASM_OUTPUT_EXTENSION 			.o
rem %dk_call% dk_set CMAKE_C_OUTPUT_EXTENSION   			.o
rem %dk_call% dk_set CMAKE_CXX_OUTPUT_EXTENSION 			.o
rem %dk_call% dk_set CMAKE_LINK_LIBRARY_SUFFIX				.a
rem %dk_call% dk_set CMAKE_LINK_LIBRARY_PREFIX	   			lib
rem %dk_call% dk_set CMAKE_C_LINK_LIBRARY_SUFFIX			.a
rem %dk_call% dk_set CMAKE_C_LINK_LIBRARY_PREFIX		   	lib
rem %dk_call% dk_set CMAKE_CXX_LINK_LIBRARY_SUFFIX			.a
rem %dk_call% dk_set CMAKE_CXX_LINK_LIBRARY_PREFIX   		lib
rem %dk_call% dk_set CMAKE_IMPORT_LIBRARY_SUFFIX      		.a
rem %dk_call% dk_set CMAKE_IMPORT_LIBRARY_PREFIX     		lib
rem ###### set cmake VARIABLES ######
rem %dk_call% dk_set CMAKE_MAKE_PROGRAM						"%COSMOPOLITAN_MAKE_PROGRAM%"
rem %dk_call% dk_set CMAKE_C_COMPILER						"%COSMOPOLITAN_C_COMPILER%"
rem %dk_call% dk_set CMAKE_CXX_COMPILER						"%COSMOPOLITAN_CXX_COMPILER%"
rem %dk_call% dk_set CMAKE_ASM_COMPILER						"%COSMOPOLITAN_ASM_COMPILER%"
rem %dk_call% dk_set CMAKE_AR								"%COSMOPOLITAN_AR%"
rem %dk_call% dk_set CMAKE_RANLIB							"%COSMOPOLITAN_RANLIB%"
rem %dk_call% dk_set CMAKE_LINKER							"%COSMOPOLITAN_LINKER%"
rem foreach(lang ASM C CXX)
rem 	if(NOT CMAKE_%lang%_COMPILER_AR)
rem 		%dk_call% dk_set CMAKE_%lang%_COMPILER_AR 		"%COSMOPOLITAN_%lang%_COMPILER_AR%"
rem 	)
rem 	if(NOT CMAKE_%lang%_COMPILER_RANLIB)
rem 		%dk_call% dk_set CMAKE_%lang%_COMPILER_RANLIB 	"%COSMOPOLITAN_%lang%_COMPILER_RANLIB%"
rem 	)
rem endforeach
rem ############ Cosmopolitan BASH EXPORTS ############
rem %dk_call% dk_set COSMOPOLITAN_BIN						"export PATH=%Cosmopolitan%/tool/cosmocc/bin:$PATH"