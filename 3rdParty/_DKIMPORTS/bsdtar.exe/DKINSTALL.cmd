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


rem ############ bsdtar.exe ############
rem # https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_linux_arm64
rem # https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_linux_amd64
rem # https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_darwin_arm64
rem # https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_darwin_amd64
rem # https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_windows_x86_64.exe
rem # https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_windows_arm64.exe

:DKINSTALL
%setlocal%

	rem ###### GET ######
	rem # 	Windows bsdtar
	"!bsdtar.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (set "bsdtar.exe=%SystemRoot:\=/%/System32/tar.exe")
	
	rem %dk_start% "!bsdtar.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (
	rem		%dk_call% dk_findFile "tar.exe" "%SystemRoot:\=/%/System32"
	rem		set "bsdtar.exe=!tar.exe!"
	rem	)
	
	
	%dk_start% "!bsdtar.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (
			%dk_call% dk_import
			if not EXIST "!bsdtar.exe!" (mkdir "!bsdtar.exe:/=\!")
			if not EXIST "!bsdtar.exe!/!bsdtar.exe_Url_Basename!" (
				copy /Y "!dk_import:/=\!" "!bsdtar.exe:/=\!\!bsdtar.exe_Url_Basename!"
			)
			set "bsdtar.exe=!bsdtar.exe!/!bsdtar.exe_Url_Basename!"
		)
		
	rem #	ANY bsdtar
	"!bsdtar.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (%dk_call% dk_findFile tar.exe)


	rem ###### TEST ######
	%dk_start% "%bsdtar.exe:/=\%" --version 1>nul 2>nul && (goto:return) || (
			if EXIST "%bsdtar.exe%" (
				%dk_call% dk_error "bsdtar.exe:'%bsdtar.exe%' FAILED"	
			) else (
				%dk_call% dk_error "bsdtar.exe:'%bsdtar.exe%' NOT FOUND"
			)
			%endfunction%
		)
	
	
	rem ###### RETURN ######
	:return
	rem %dk_call% dk_firewallAllow "%bsdtar.exe%"
	endlocal & (
		set "bsdtar.exe=%bsdtar.exe:\=/%"
	)
	rem %dk_call% dk_debug "bsdtar.exe = %bsdtar.exe%"
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo.
	echo ####### Test dk_depend bsdtar.exe ######
	set "bsdtar.exe="
	%dk_call% dk_validate bsdtar.exe %dk_call% dk_depend bsdtar.exe
	%dk_start% "%bsdtar.exe:/=\%" --version && (echo SUCCESS) || (echo FAILED)
	
	echo.
	echo ###### Test %%dk_call%% bsdtar.exe ######
	set "bsdtar.exe="
	%dk_call% bsdtar.exe --version && (echo SUCCESS) || (echo FAILED)
%endfunction%