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


rem ############ curl_exe ############
rem # https://github.com/curl/curl
rem # https://curl.se/
rem # https://robertying.io/posts/compile-openssl-and-curl-for-android
rem # https://curl.se/docs/install.html
rem #
:DKINSTALL
%setlocal%
	
rem	%dk_call% dk_import
	
	%dk_start% "!curl_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (set "curl_exe=%SystemRoot:\=/%/System32/curl.exe")
	%dk_start% "!curl_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (set "curl_exe=%DKTOOLS_DIR%/curl/curl.exe")
	%dk_start% "!curl_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (%dk_call% dk_findFile curl.exe)
	%dk_start% "!curl_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (
		%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
		set "curl_exe=%DKTOOLS_DIR%/curl/curl.exe"
		if NOT EXIST "%curl_exe%" (
			%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
			rem "C:\Windows\System32\curl.exe" --show-error --remote-time --location --remove-on-error --create-dirs --output "!DKDOWNLOAD_DIR!/curl" "https://cosmo.zip/pub/cosmos/bin/curl"
			%dk_call% DK :dk_download "https://cosmo.zip/pub/cosmos/bin/curl" "!DKDOWNLOAD_DIR!/curl"
			%dk_call% dk_mkdir "%DKTOOLS_DIR%/curl"
			%dk_call% dk_copy "!DKDOWNLOAD_DIR!/curl" "%curl_exe%"
		)
	)
	
	rem set curl_exe=%dk_start% "%DKTOOLS_DIR:/=\%\curl\curl"
	
	rem %dk_start% "!curl_exe:/=\!" --version
	
	:return
	%dk_call% dk_firewallAllow "%curl_exe%"
	endlocal & (
		set "curl_exe=%curl_exe%"
	)	
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "curl_exe="
	%dk_call% dk_validate curl_exe %dk_call% dk_depend curl_exe
	%dk_call% dk_debug "curl_exe = %curl_exe%"
%endfunction%