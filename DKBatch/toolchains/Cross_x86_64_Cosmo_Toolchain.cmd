@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
rem  #################################################################################################################################################


%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################## Cross_x86_64_Cosmo_Toolchain.cmake ######################"
%dk_call% dk_echo "############################################################################"

rem %dk_call% dk_depend cosmopolitan
%dk_call% dk_depend make

%dk_call% dk_set CMAKE_SYSTEM_NAME 						"Generic"
%dk_call% dk_set Cosmopolitan 							1
%dk_call% dk_set CMAKE_SKIP_RPATH 						"ON"
%dk_call% dk_set CMAKE_CROSSCOMPILING 					"OFF"

%dk_call% dk_validate Host_Tuple "dk_Host_Tuple"
if defined Windows_Host (
	%dk_call% dk_set CMAKE_GENERATOR					"MSYS Makefiles"
) else (	
	%dk_call% dk_set CMAKE_GENERATOR					"Unix Makefiles"
)
rem  %dk_call% dk_set CMAKE_FORCE_UNIX_PATHS 			1
rem  %dk_call% dk_append CMAKE_C_FLAGS					-DCOSMOPOLITAN)# -std=gnu17)   # -D_CRT_SECURE_NO_WARNINGS 
rem  %dk_call% dk_append CMAKE_CXX_FLAGS				-DCOSMOPOLITAN)# -std=gnu++17) # -D_CRT_SECURE_NO_WARNINGS
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS			"-static"  &rem  -s)

rem  %dk_call% dk_append DKCONFIGURE_FLAGS				"--build=x86_64-w64"
rem  %dk_call% dk_set DKCONFIGURE_CC					"%CMAKE_C_COMPILER%"
rem  %dk_call% dk_set DKCONFIGURE_CXX					"%CMAKE_CXX_COMPILER%"
rem  %dk_call% dk_append DKCONFIGURE_CFLAGS				"%CMAKE_C_FLAGS%"
rem  %dk_call% dk_append DKCONFIGURE_CXXFLAGS			"%CMAKE_CXX_FLAGS%"

%dk_call% dk_validate %DKIMPORTS_DIR%					"dk_DKIMPORTS_DIR"
rem  %dk_call% dk_append DKCMAKE_FLAGS
rem	-DCMAKE_USER_MAKE_RULES_OVERRIDE=$%DKIMPORTS_DIR%/Cosmopolitan/cosmo_user_make_rules_override.cmake
rem	-DCMAKE_C_COMPILER_WORKS=1
rem	-DCMAKE_CXX_COMPILER_WORKS=1
%dk_call% dk_set CMAKE_C_COMPILER_WORKS					1
%dk_call% dk_set CMAKE_CXX_COMPILER_WORKS        		1
%dk_call% dk_set CMAKE_CXX_FLAGS_INIT 					-fexceptions -frtti
%dk_call% dk_set CMAKE_USER_MAKE_RULES_OVERRIDE 		$%DKIMPORTS_DIR%/Cosmopolitan/cosmo_user_make_rules_override.cmake
%dk_call% dk_set CMAKE_ASM_OUTPUT_EXTENSION 			.o
%dk_call% dk_set CMAKE_C_OUTPUT_EXTENSION   			.o
%dk_call% dk_set CMAKE_CXX_OUTPUT_EXTENSION 			.o
%dk_call% dk_set CMAKE_LINK_LIBRARY_SUFFIX				.a
%dk_call% dk_set CMAKE_LINK_LIBRARY_PREFIX	   			lib
%dk_call% dk_set CMAKE_C_LINK_LIBRARY_SUFFIX			.a
%dk_call% dk_set CMAKE_C_LINK_LIBRARY_PREFIX	   		lib
%dk_call% dk_set CMAKE_CXX_LINK_LIBRARY_SUFFIX			.a
%dk_call% dk_set CMAKE_CXX_LINK_LIBRARY_PREFIX   		lib
%dk_call% dk_set CMAKE_IMPORT_LIBRARY_SUFFIX      		.a
%dk_call% dk_set CMAKE_IMPORT_LIBRARY_PREFIX     		lib

rem ###### set CMAKE VARIABLES ######
%dk_call% dk_set CMAKE_MAKE_PROGRAM						"%COSMOPOLITAN_MAKE_PROGRAM%"
%dk_call% dk_set CMAKE_C_COMPILER						"%COSMOPOLITAN_C_COMPILER%"
%dk_call% dk_set CMAKE_CXX_COMPILER						"%COSMOPOLITAN_CXX_COMPILER%"
%dk_call% dk_set CMAKE_ASM_COMPILER						"%COSMOPOLITAN_ASM_COMPILER%"
%dk_call% dk_set CMAKE_AR								"%COSMOPOLITAN_AR%"
%dk_call% dk_set CMAKE_RANLIB							"%COSMOPOLITAN_RANLIB%"
%dk_call% dk_set CMAKE_LINKER							"%COSMOPOLITAN_LINKER%"
rem foreach(lang ASM C CXX)
	if(NOT CMAKE_%lang%_COMPILER_AR)
		%dk_call% dk_set CMAKE_%lang%_COMPILER_AR 		"%COSMOPOLITAN_%lang%_COMPILER_AR%"
	)
	if(NOT CMAKE_%lang%_COMPILER_RANLIB)
		%dk_call% dk_set CMAKE_%lang%_COMPILER_RANLIB 	"%COSMOPOLITAN_%lang%_COMPILER_RANLIB%"
	)
rem endforeach


rem ############ Cosmopolitan BASH EXPORTS ############
%dk_call% dk_set COSMOPOLITAN_BIN						"export PATH=%Cosmopolitan%/tool/cosmocc/bin:$PATH"