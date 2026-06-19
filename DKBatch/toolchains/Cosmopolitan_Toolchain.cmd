%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "##################### Cosmopolitan_toolchain.cmd #########################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_prependArgs CMAKE_ARGS -DCOSMOPOLITAN=1
set CMAKE_GENERATOR="MSYS Makefiles"








rem %dk_call% 					dk_depend 						cosmopolitan
rem %dk_call% 					dk_depend 						make
rem %dk_call% dk_set			Cosmopolitan 					1
rem %dk_call% dk_set 			CMAKE_SYSTEM_NAME 				"Generic"
rem %dk_call% dk_set 			CMAKE_SKIP_RPATH 				"ON"
rem %dk_call% dk_set 			CMAKE_CROSSCOMPILING 			"OFF"
rem %dk_call% dk_validate 		MSYS2 							%dk_call% dk_depend msys2
rem %dk_call% dk_prependEnvPath 								"%msys2%/usr/bin"
rem %dk_call% dk_validate 		COSMOCC 						%dk_call% dk_depend cosmocc
rem %dk_call% dk_prependEnvPath 								"%COSMOCC%/bin"
rem %dk_call% dk_prependEnvPath 								"%Cosmopolitan%/tool/cosmocc/bin"
rem %dk_call% dk_validate 		Host_Tuple 						"dk_Host_Tuple"
rem if defined Windows_Host (
rem 	%dk_call% dk_set 		CMAKE_GENERATOR					"MSYS Makefiles"
rem ) else (
rem 	%dk_call% dk_set 		CMAKE_GENERATOR					"Unix Makefiles"
rem )
rem %dk_call% dk_set 			CMAKE_FORCE_UNIX_PATHS 			1
rem  %dk_call% dk_append 		CMAKE_C_FLAGS					-DCOSMOPOLITAN)# -std=gnu17)   # -D_CRT_SECURE_NO_WARNINGS
rem  %dk_call% dk_append 		CMAKE_CXX_FLAGS					-DCOSMOPOLITAN)# -std=gnu++17) # -D_CRT_SECURE_NO_WARNINGS
rem  %dk_call% dk_append 		cmake_exe_LINKER_FLAGS			-static  &rem  -s)
rem %dk_call% dk_validate 		%DKIMPORTS_DIR%					"dk_DKIMPORTS_DIR"
rem  %dk_call% dk_append 		DKCMAKE_FLAGS
rem	-DCMAKE_USER_MAKE_RULES_OVERRIDE=$%DKIMPORTS_DIR%/Cosmopolitan/cosmopolitan_user_make_rules_override.cmd
rem -DCMAKE_C_COMPILER_WORKS=1
rem	-DCMAKE_CXX_COMPILER_WORKS=1
rem %dk_call% dk_set 			CMAKE_AR						"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
rem %dk_call% dk_set 			CMAKE_ASM_COMPILER				"%Cosmopolitan%/tool/cosmocc/bin/cosmocc"
rem %dk_call% dk_set 			CMAKE_ASM_COMPILER_AR			"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
rem %dk_call% dk_set 			CMAKE_ASM_COMPILER_RANLIB		"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
rem %dk_call% dk_set 			CMAKE_ASM_OUTPUT_EXTENSION 		".o"
rem %dk_call% dk_set 			CMAKE_CXX_COMPILER				"%Cosmopolitan%/tool/cosmocc/bin/cosmoc++"
rem %dk_call% dk_set 			CMAKE_CXX_COMPILER_AR			"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
rem %dk_call% dk_set 			CMAKE_CXX_COMPILER_RANLIB		"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
rem %dk_call% dk_set 			CMAKE_CXX_COMPILER_WORKS        "1"
rem %dk_call% dk_set 			CMAKE_CXX_FLAGS_INIT 			-fexceptions -frtti
rem %dk_call% dk_set 			CMAKE_CXX_OUTPUT_EXTENSION 		".o"
rem %dk_call% dk_set 			CMAKE_C_COMPILER				"%Cosmopolitan%/tool/cosmocc/bin/cosmocc"
rem %dk_call% dk_set 			CMAKE_C_COMPILER_AR				"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
rem %dk_call% dk_set 			CMAKE_C_COMPILER_RANLIB			"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
rem %dk_call% dk_set 			CMAKE_C_COMPILER_WORKS			1
rem %dk_call% dk_set 			CMAKE_C_OUTPUT_EXTENSION   		".o"
rem %dk_call% dk_set 			CMAKE_LINKER						
rem %dk_call% dk_set 			CMAKE_MAKE_PROGRAM					
rem %dk_call% dk_set 			CMAKE_RANLIB					"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
rem %dk_call% dk_set 			CMAKE_USER_MAKE_RULES_OVERRIDE 	"%DKIMPORTS_DIR%/Cosmopolitan/cosmopolitan_user_make_rules_override.cmd"
rem  %dk_call% dk_set 			DKCONFIGURE_CC					"%CMAKE_C_COMPILER%"
rem  %dk_call% dk_set 			DKCONFIGURE_CXX					"%CMAKE_CXX_COMPILER%"
rem  %dk_call% dk_append 		DKCONFIGURE_FLAGS				"--build=x86_64-w64"
rem  %dk_call% dk_append 		DKCONFIGURE_CFLAGS				"%CMAKE_C_FLAGS%"
rem  %dk_call% dk_append 		DKCONFIGURE_CXXFLAGS			"%CMAKE_CXX_FLAGS%"
