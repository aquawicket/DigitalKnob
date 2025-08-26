<!-- :
@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# ___NEW_IMPORT()
::#
::#
:___NEW_IMPORT
setlocal
	%dk_call% dk_debugFunc 0

	for /f "tokens=* delims=" %%A in ('cmd /c mshta.exe "%~f0"') do (
		set "str=%%A"
	)
	
	%dk_call% String/dk_split "%str%"
	set "PLUGIN_Url=%dk_split[0]%"
	set "PLUGIN_Import_Name=%dk_split[1]%"
	
	%dk_call% dk_echo "PLUGIN_Url = %PLUGIN_Url%"
	%dk_call% dk_echo "PLUGIN_Import_Name = %PLUGIN_Import_Name%"
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if EXIST "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%" (
		%dk_call% dk_notice "%DKIMPORTS_DIR%/%PLUGIN_Import_Name% already exists"
		%return%
	)

	%dk_call% dk_mkdir "%DKIMPORTS_DIR%/%PLUGIN_Import_Name%"
	
	::%dk_call% dk_toUpper "%PLUGIN_Url_Import%"
	::%dk_call% dk_printVar dk_toUpper
	
::###### dkconfig.txt ######
echo %PLUGIN_Import_Name%_Import=%PLUGIN_Url%> 										"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/dkconfig.txt"

::###### DKINSTALL.cmake ######
echo(#!/usr/bin/cmake -P>															"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(### DK.cmake ############################################################>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")>>						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(	cmake_policy(SET CMP0009 NEW)>>												"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(	file(GLOB_RECURSE DK.cmake "/DK.cmake")>>									"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(	list(GET DK.cmake 0 DK.cmake)>>												"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)>>		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")>>				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(endif()>>																		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")>>								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(include_guard()>>																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(#########################################################################>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(###### %PLUGIN_Import_Name% ######>>											"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(# %PLUGIN_Url%>>																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(### INSTALL ###>>																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(#dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")>>					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(#dk_getFileParams	("$ENV{DKIMPORTS_DIR}/%PLUGIN_Import_Name%/dkconfig.txt")>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(#dk_import			(${%PLUGIN_Import_Name%_Import})>>							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"
echo(dk_import()>>																	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake"

::###### DKUNINSTALL.cmake ######
echo(#!/usr/bin/cmake -P>															"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(### DK.cmake ############################################################>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")>>						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(	cmake_policy(SET CMP0009 NEW)>>												"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(	file(GLOB_RECURSE DK.cmake "/DK.cmake")>>									"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(	list(GET DK.cmake 0 DK.cmake)>>												"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)>>		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")>>				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(endif()>>																		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")>>								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(include_guard()>>																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(#########################################################################>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(###### %PLUGIN_Import_Name% ######>>											"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(# %PLUGIN_Url%>>																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(### UnINSTALL ###>>															"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")>>					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(dk_getFileParams	("$ENV{DKIMPORTS_DIR}/%PLUGIN_Import_Name%/dkconfig.txt")>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(dk_importVariables	(${%PLUGIN_Import_Name%_Import} NAME %PLUGIN_Import_Name%)>>"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"
echo(dk_delete			("${%PLUGIN_Import_Name%}")>>								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake"

::###### DKINSTALL.cmd ######
echo(@echo off^&::###### DK.cmd #########################################################################################################################> 			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)>>									"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(if NOT EXIST "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" for /F "tokens=*" %%%%G IN ('where /r "%%USERPROFILE%%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%%%~dpG")>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(if NOT defined DK.cmd (call "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" "%%~0" %%*)>>																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(::#################################################################################################################################################>> 			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(::####################################################################>>																						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(::# DKINSTALL>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(::#>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(:DKINSTALL>>																																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(%%setlocal%%>>																																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(	%%dk_call%% dk_debugFunc 0 >>																																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(	%%dk_call%% dk_import>>																																		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(%%endfunction%%>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmd"

::###### DKUNINSTALL.cmd ######
echo(@echo off^&::###### DK.cmd #########################################################################################################################> 			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)>>									"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(if NOT EXIST "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" for /F "tokens=*" %%%%G IN ('where /r "%%USERPROFILE%%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%%%~dpG")>>	"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(if NOT defined DK.cmd (call "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" "%%~0" %%*)>>																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(::#################################################################################################################################################>> 			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(::####################################################################>>																						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(::# DKUNINSTALL>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(::#>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(:DKUNINSTALL>>																																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(%%setlocal%%>>																																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(	%%dk_call%% dk_debugFunc 0 >>																																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(	::%%dk_call%% dk_uninstall ##### TODO #####>>																												"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(%%endfunction%%>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"
echo(>>																																								"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmd"






::###### DKINSTALL.cmake.cmd ######
::echo(@echo off^&::###### DK.cmd #########################################################################################################################> 		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(if NOT EXIST "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" for /F "tokens=*" %%%%G IN ('where /r "%%USERPROFILE%%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%%%~dpG")>>"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(if NOT defined DK.cmd (call "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" "%%~0" %%*)>>																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(::#################################################################################################################################################>> 		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(::####################################################################>>																						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(::# DKINSTALL>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(::#>>																																						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(:DKINSTALL>>																																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(%%setlocal%%>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(	%%dk_call%% dk_debugFunc 0 >>																																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(	%%dk_call%% dk_cmakeEval "dk_load('%%~dpn0')">>																												"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(%%endfunction%%>>																																			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(:DKTEST>>																																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(%%setlocal%%>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(	%%dk_call%% dk_debugFunc 0 >>																																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(	call :DKINSTALL>>																																			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"
::echo(%%endfunction%%>>																																			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKINSTALL.cmake.cmd"

::###### DKUNINSTALL.cmake.cmd ######
::echo(@echo off^&::###### DK.cmd #########################################################################################################################> 		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(if NOT EXIST "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" for /F "tokens=*" %%%%G IN ('where /r "%%USERPROFILE%%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%%%~dpG")>>"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(if NOT defined DK.cmd (call "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" "%%~0" %%*)>>																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(::#################################################################################################################################################>> 		"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(::####################################################################>>																						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(::# DKUNINSTALL>>																																			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(::#>>																																						"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(:DKUNINSTALL>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(%%setlocal%%>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(	%%dk_call%% dk_debugFunc 0 >>																																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(	%%dk_call%% dk_cmakeEval "dk_load('%%~dpn0')">>																												"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(%%endfunction%%>>																																			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(:DKTEST>>																																					"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(%%setlocal%%>>																																				"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(	%%dk_call%% dk_debugFunc 0 >>																																"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(>>																																							"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(	call :DKUNINSTALL>>																																			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"
::echo(%%endfunction%%>>																																			"%DKIMPORTS_DIR%/%PLUGIN_Import_Name%/DKUNINSTALL.cmake.cmd"


%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_IMPORT
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
