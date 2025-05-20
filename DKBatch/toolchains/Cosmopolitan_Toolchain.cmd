::@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::######################################################################################################################################################

:: FIXME
%return%

%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "##################### Cosmopolitan_Toolchain.cmd #########################"
%dk_call% dk_echo "############################################################################"

%dk_call% 						dk_depend 						cosmopolitan
rem %dk_call% 					dk_depend 						make

rem %dk_call% dk_set			Cosmopolitan 					1
rem %dk_call% dk_set 			CMAKE_SYSTEM_NAME 				"Generic"
%dk_call% dk_set 				CMAKE_SKIP_RPATH 				"ON"
%dk_call% dk_set 				CMAKE_CROSSCOMPILING 			"OFF"

%dk_call% dk_validate 			MSYS2 							"%dk_call% dk_depend msys2"
%dk_call% dk_prependEnvPath 									"%MSYS2%/usr/bin"

%dk_call% dk_validate 			COSMOCC 						"%dk_call% dk_depend cosmocc"
%dk_call% dk_prependEnvPath 									"%COSMOCC%/bin"

%dk_call% dk_prependEnvPath 									"%Cosmopolitan%/tool/cosmocc/bin"

%dk_call% dk_validate 			Host_Tuple 						"dk_Host_Tuple"
if defined Windows_Host (
	%dk_call% dk_set 			CMAKE_GENERATOR					"MSYS Makefiles"
) else (
	%dk_call% dk_set 			CMAKE_GENERATOR					"Unix Makefiles"
)
%dk_call% dk_set 				CMAKE_FORCE_UNIX_PATHS 				1
rem  %dk_call% dk_append 		CMAKE_C_FLAGS					-DCOSMOPOLITAN)# -std=gnu17)   # -D_CRT_SECURE_NO_WARNINGS 
rem  %dk_call% dk_append 		CMAKE_CXX_FLAGS					-DCOSMOPOLITAN)# -std=gnu++17) # -D_CRT_SECURE_NO_WARNINGS
rem  %dk_call% dk_append 		CMAKE_EXE_LINKER_FLAGS			-static  &rem  -s)

%dk_call% dk_validate 			%DKIMPORTS_DIR%					"dk_DKIMPORTS_DIR"
rem  %dk_call% dk_append 		DKCMAKE_FLAGS
rem	-DCMAKE_USER_MAKE_RULES_OVERRIDE=$%DKIMPORTS_DIR%/Cosmopolitan/cosmopolitan_user_make_rules_override.cmd
rem -DCMAKE_C_COMPILER_WORKS=1
rem	-DCMAKE_CXX_COMPILER_WORKS=1
	
%dk_call% dk_set 				CMAKE_AR						"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
%dk_call% dk_set 				CMAKE_ASM_COMPILER				"%Cosmopolitan%/tool/cosmocc/bin/cosmocc"
%dk_call% dk_set 				CMAKE_ASM_COMPILER_AR			"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
%dk_call% dk_set 				CMAKE_ASM_COMPILER_RANLIB		"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
%dk_call% dk_set 				CMAKE_ASM_OUTPUT_EXTENSION 		".o"
%dk_call% dk_set 				CMAKE_CXX_COMPILER				"%Cosmopolitan%/tool/cosmocc/bin/cosmoc++"
%dk_call% dk_set 				CMAKE_CXX_COMPILER_AR			"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
%dk_call% dk_set 				CMAKE_CXX_COMPILER_RANLIB		"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
%dk_call% dk_set 				CMAKE_CXX_COMPILER_WORKS        "1"
%dk_call% dk_set 				CMAKE_CXX_FLAGS_INIT 			-fexceptions -frtti
%dk_call% dk_set 				CMAKE_CXX_OUTPUT_EXTENSION 		".o"
%dk_call% dk_set 				CMAKE_C_COMPILER				"%Cosmopolitan%/tool/cosmocc/bin/cosmocc"
%dk_call% dk_set 				CMAKE_C_COMPILER_AR				"%Cosmopolitan%/tool/cosmocc/bin/cosmoar"
%dk_call% dk_set 				CMAKE_C_COMPILER_RANLIB			"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
%dk_call% dk_set 				CMAKE_C_COMPILER_WORKS			1
%dk_call% dk_set 				CMAKE_C_OUTPUT_EXTENSION   		".o"
rem %dk_call% dk_set 			CMAKE_LINKER						
rem %dk_call% dk_set 			CMAKE_MAKE_PROGRAM					
%dk_call% dk_set 				CMAKE_RANLIB					"%Cosmopolitan%/tool/cosmocc/bin/cosmoranlib"
%dk_call% dk_set 				CMAKE_USER_MAKE_RULES_OVERRIDE 	"%DKIMPORTS_DIR%/Cosmopolitan/cosmopolitan_user_make_rules_override.cmd"



rem  %dk_call% dk_set 			DKCONFIGURE_CC					"%CMAKE_C_COMPILER%"
rem  %dk_call% dk_set 			DKCONFIGURE_CXX					"%CMAKE_CXX_COMPILER%"
rem  %dk_call% dk_append 		DKCONFIGURE_FLAGS				"--build=x86_64-w64"
rem  %dk_call% dk_append 		DKCONFIGURE_CFLAGS				"%CMAKE_C_FLAGS%"
rem  %dk_call% dk_append 		DKCONFIGURE_CXXFLAGS			"%CMAKE_CXX_FLAGS%"
