@echo off&rem ###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
rem #################################################################################################################################################


rem ############################################################################
rem # dk_screenResolution()
rem #	gets the screen resolution depending on the windows version.
rem #
:dk_screenResolution
%setlocal%
 
	for /f "tokens=4,5 delims=. " %%a in ('ver') do set "version=%%a%%b"
	%dk_call% dk_validate WMIC.exe %dk_call% dk_findFile WMIC.exe 
	if version lss 62 (
		rem set "wmic_query=wmic desktopmonitor get screenheight, screenwidth /format:value"
		for /f "tokens=* delims=" %%@ in ('%WMIC.exe:/=\% desktopmonitor get screenwidth /format:value') do (
			for /f "tokens=2 delims==" %%# in ("%%@") do set "x=%%#"
		)
		for /f "tokens=* delims=" %%@ in ('%WMIC.exe:/=\% desktopmonitor get screenheight /format:value') do (
			for /f "tokens=2 delims==" %%# in ("%%@") do set "y=%%#"
		)

	) else (
		rem wmic path Win32_VideoController get VideoModeDescription,CurrentVerticalResolution,CurrentHorizontalResolution /format:value
		for /f "tokens=* delims=" %%@ in ('%WMIC.exe:/=\% path Win32_VideoController get CurrentHorizontalResolution  /format:value') do (
			for /f "tokens=2 delims==" %%# in ("%%@") do set "x=%%#"
		)
		for /f "tokens=* delims=" %%@ in ('%WMIC.exe:/=\% path Win32_VideoController get CurrentVerticalResolution /format:value') do (
			for /f "tokens=2 delims==" %%# in ("%%@") do set "y=%%#"
		)
	)
	set "dk_screenResolution=%x%x%y%"

	:return
	endlocal & (
		set "dk_screenResolution=%dk_screenResolution%"
	)
	rem %dk_call% dk_debug "dk_screenResolution = %dk_screenResolution%"
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_screenResolution
	%dk_call% dk_debug "dk_screenResolution = %dk_screenResolution%"
%endfunction%

