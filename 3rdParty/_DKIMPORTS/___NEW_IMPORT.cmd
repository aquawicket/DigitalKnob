<!-- :
rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # ___NEW_IMPORT()
rem #
rem #
:___NEW_IMPORT
rem %setlocal%

	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
	for /f "tokens=* delims=" %%A in ('%ComSpec% /c %mshta.exe:/=\% "%~f0"') do (
		set "str=%%A"
	)

	%dk_call% String/dk_split "%str%"
	set "PLUGIN_Url=%dk_split[0]%"
	set "PLUGIN_Import_Name=%dk_split[1]%"

	%dk_call% dk_echo "PLUGIN_Url = %PLUGIN_Url%"
	%dk_call% dk_echo "PLUGIN_Import_Name = %PLUGIN_Import_Name%"

	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	if EXIST "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%" (
		%dk_call% dk_notice "%DKIMPORTS_DIR%/%PLUGIN_Import_Name% already exists"
		%return%
	)

	%dk_call% dk_mkdir "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%"

rem ############ dkconfig.txt ############
> "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/dkconfig.txt" (
	echo.############ %PLUGIN_Import_Name% ############
	echo.# %PLUGIN_Url%
	echo.
	echo.%PLUGIN_Import_Name%_Import=%PLUGIN_Url%
	echo.
)


rem ############ DKINSTALL.cmake ############
> "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake" (
	echo.#!/usr/bin/cmake -P
	echo.### DK.cmake ############################################################
	echo.if^(NOT DEFINED DK.cmake^)
	echo.	if^(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake"^)
	echo.		cmake_policy^(SET CMP0009 NEW^)
	echo.		file^(GLOB_RECURSE DK_cmake "/DK.cmake"^)
	echo.		list^(GET DK_cmake 0 DK_cmake^)
	echo.		get_filename_component^(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY^)
	echo.		set^(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/"^)
	echo.	endif^(^)
	echo.	include^("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake"^)
	echo.endif^(^)
	echo.#########################################################################
	echo.
	echo.
	echo.############ %PLUGIN_Import_Name% ############
	echo.# %PLUGIN_Url%
	echo.#
	echo.function^(DKINSTALL^)
	echo.    dk_debugFunc^(^)
	echo.
	echo.    dk_import^(^)
	echo.endfunction^(^)
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	echo.function^(DKTEST^)
	echo.	dk_debugFunc^(0^)
	echo.
	echo.	DKINSTALL^(^)
	echo.endfunction^(^)
	echo.																		
)

rem ############ DKUNINSTALL.cmake ############
> "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake" (
	echo.#!/usr/bin/cmake -P
	echo.### DK.cmake ############################################################
	echo.if^(NOT DEFINED DK.cmake^)
	echo.	if^(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake"^)
	echo.		cmake_policy^(SET CMP0009 NEW^)
	echo.		file^(GLOB_RECURSE DK_cmake "/DK.cmake"^)
	echo.		list^(GET DK_cmake 0 DK_cmake^)
	echo.		get_filename_component^(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY^)
	echo.		set^(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/"^)
	echo.	endif^(^)
	echo.	include^("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake"^)
	echo.endif^(^)
	echo.#########################################################################
	echo.
	echo.
	echo.############ %PLUGIN_Import_Name% ############
	echo.# %PLUGIN_Url%
	echo.#
	echo.function^(DKUNINSTALL^)
	echo.    dk_debugFunc^(^)
	echo.
	echo.    dk_validate		^(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()"^)
	echo.    dk_fileVariables	^("$ENV{DKIMPORTS_DIR}/%PLUGIN_Import_Name%/dkconfig.txt"^)
	echo.    dk_importVariables	^(${%PLUGIN_Import_Name%_Import} NAME %PLUGIN_Import_Name%^)
	echo.    dk_delete			^("${%PLUGIN_Import_Name%}"^)
	echo.endfunction^(^)
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	echo.function^(DKTEST^)
	echo.	dk_debugFunc^(0^)
	echo.
	echo.	DKUNINSTALL^(^)
	echo.endfunction^(^)
	echo.
)

rem ############ DKINSTALL.cmd ############
> "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd" (
	echo.rem shebang
	echo.@echo off^&rem ###### DK.cmd #########################################################################################################################
	echo.if not defined DKINIT_cmd ^(
	echo.	setlocal enableDelayedExpansion
	echo.	if NOT EXIST "%%DKBATCH_FUNCTIONS_DIR_%%" ^(set DKBATCH_FUNCTIONS_DIR_=%%USERPROFILE:\=/%%/%DigitalKnob%/%DKBranch%/DKBatch/functions/^)
	echo.	if NOT EXIST "^!DKBATCH_FUNCTIONS_DIR_^!" for /F "delims=" %%%%G IN ^('dir /b/s/a:-d "%%USERPROFILE%%\DK.cmd"'^) do ^(set "DKBATCH_FUNCTIONS_DIR_=%%%%~dpG"^)
	echo.	call "^!DKBATCH_FUNCTIONS_DIR_^!DK.cmd" "%%~0" %%*
	echo.	exit /b %%errorlevel%%
	echo.^)
	echo.rem #################################################################################################################################################
	echo.
	echo.
	echo.rem ############ %PLUGIN_Import_Name% ############
	echo.rem # %PLUGIN_Url%
	echo.
	echo.:DKINSTALL
	echo.%%setlocal%%
	echo.
	echo.	%%dk_call%% dk_import
	echo.
	echo.%%endfunction%%
	echo.
)

rem ############ DKUNINSTALL.cmd ############
> "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd" (
	echo.rem shebang
	echo.@echo off^&rem ###### DK.cmd #########################################################################################################################
	echo.if not defined DKINIT_cmd (
	echo.	setlocal enableDelayedExpansion
	echo.	if NOT EXIST "%%DK.cmd%%" (set "DK.cmd=%%USERPROFILE%%\Digital Knob\Development\DKBatch\functions\DK.cmd"^)
	echo.	if NOT EXIST "!DK.cmd!" (for /F "tokens=*" %%%%G IN ('dir /b/s/a:-d "%%USERPROFILE%%\DK.cmd"'^) do (set "DK.cmd=%%%%~fG"^)^)
	echo.	if NOT EXIST "!DK.cmd!" (
	echo.		"%%SystemRoot%%\System32\curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd^)
	echo.	call "!DK.cmd:/=\!" "%%~0" %%*
	echo.	exit /b %%errorlevel%%
	echo.)
	echo.rem #################################################################################################################################################
	echo.
	echo.
	echo.rem ############ %PLUGIN_Import_Name% ############
	echo.rem # %PLUGIN_Url%
	echo.
	echo.:DKUNINSTALL
	echo.%%setlocal%%
	echo.
	echo.	%%dk_call%% dk_unimport
	echo.
	echo.%%endfunction%%
	echo.
)

	%dk_call% dk_validate explorer.exe %dk_call% dk_depend explorer.exe
	"%explorer.exe%" "%DKIMPORTS_DIR:/=\%\%PLUGIN_Import_Name%"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 
	%dk_call% ___NEW_IMPORT.cmd
%endfunction%


### https://learn.microsoft.com/en-us/previous-versions/ms536495(v=vs.85) ### -->
<html>
	<head>
		<TITLE>__NEW_IMPORT</TITLE>
		<HTA:APPLICATION ID="__NEW_IMPORT"
			APPLICATIONNAME="__NEW_IMPORT"
			BORDER="thin"
			BORDERSTYLE="normal"
			CAPTION="yes"
			ICON=""
			MAXIMIZEBUTTON="no"
			MINIMIZEBUTTON="no"
			NAVIGABLE="no"
			SCROLL="no"
			SHOWINTASKBAR="no"
			SINGLEINSTANCE="yes"
			SYSMENU="no"
			VERSION="1.0"/>
	</head>
	<body onLoad='load(event)' onkeypress='keyPress(event)'>
		LINK: <input type="text" id="PLUGIN_Url" value="" style="width:80%">
		NAME: <input type="text" id="PLUGIN_Import_Name" value="" style="width:80%">
		<button onclick='submit()'>Submit</button>
		<button onclick='cancel()'>Cancel</button>
		<script language='javascript' >
			window.resizeTo(500,150);
			function load(e){
				var PLUGIN_Url = document.getElementById('PLUGIN_Url');
				var PLUGIN_Import_Name = document.getElementById('PLUGIN_Import_Name');
				PLUGIN_Url.select();
			}
			function keyPress(e){
				if (e.keyCode == 13) {
					submit();
				}
			}
			function submit() {
				var PLUGIN_Url=document.getElementById('PLUGIN_Url').value;
				var PLUGIN_Import_Name=document.getElementById('PLUGIN_Import_Name').value;
				output = PLUGIN_Url+";"+PLUGIN_Import_Name;
				
				var stdout = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
				close(stdout.Write(output));
			}
			function cancel() {
				close();
			}
		</script>
	</body>
</html>
