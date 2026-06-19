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


rem ############ curl ############
rem # https://github.com/curl/curl
rem # https://curl.se/
rem # https://robertying.io/posts/compile-openssl-and-curl-for-android
rem # https://curl.se/docs/install.html
rem #
:DKINSTALL
%setlocal%

	rem ###### GET ######
	rem # 	Windows curl
	"!curl.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (set "curl.exe=%SystemRoot:\=/%/System32/curl.exe")
	
	rem #	Git curl
	"!curl.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (set "curl.exe=!git!/mingw64/bin/curl.exe")
	
	rem #	Cosmo curl
	%dk_start% "!curl.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (
			%dk_call% dk_validate DKTOOLS_DIR 	%dk_call% dk_DKTOOLS_DIR
			set "curl.exe=!DKTOOLS_DIR!/cosmos/curl"
			if NOT EXIST "!curl.exe!" (
				%dk_call% dk_validate DKDOWNLOAD_DIR 	%dk_call% dk_DKDOWNLOAD_DIR
				%dk_call% DK :dk_download "https://cosmo.zip/pub/cosmos/bin/curl" "!DKDOWNLOAD_DIR!/curl"
				%dk_call% dk_copy "!DKDOWNLOAD_DIR!/curl" "!curl.exe!"
			)
		)

	rem # Curl curl
	"!curl.exe:/=\!" --version 1>nul && (goto:return) || (
		%dk_call% dk_validate DKTOOLS_DIR   %dk_call% dk_DKTOOLS_DIR
		set "curl.exe=!DKTOOLS_DIR!/curl-8.18.0_2-win64-mingw/bin/curl.exe"
		if NOT EXIST "!curl.exe!" (
			%dk_call% dk_validate DKDOWNLOAD_DIR   %dk_call% dk_DKDOWNLOAD_DIR
			%dk_call% DK :dk_download "https://curl.se/windows/dl-8.18.0_2/curl-8.18.0_2-win64-mingw.zip" "!DKDOWNLOAD_DIR!/curl-8.18.0_2-win64-mingw.zip"
			%dk_call% dk_smartExtract "!DKDOWNLOAD_DIR!/curl-8.18.0_2-win64-mingw.zip" "!DKTOOLS_DIR!/curl-8.18.0_2-win64-mingw"
		)
	)

	rem #	ANY curl
	"!curl.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (%dk_call% dk_findFile curl.exe)


	rem ###### TEST #######
	%dk_start% "!curl.exe:/=\!" --version 1>nul 2>nul && (goto:return) || (
			if exist "!curl.exe!" (
				%dk_call% dk_error "curl.exe:'%curl.exe%' FAILED"
			) else (
				%dk_call% dk_error "curl.exe:'%curl.exe%' NOT FOUND"
			)
			%endfunction%
		)


	rem ###### RETURN ######
	:return
	%dk_call% dk_firewallAllow "%curl.exe%"
	endlocal & (
		set "curl.exe=%curl.exe%"
	)
	rem %dk_call% dk_debug "curl.exe = %curl.exe%"
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	echo.
rem	echo ####### Test dk_depend curl.exe ######
rem	set "curl.exe="
rem	%dk_call% dk_validate curl.exe %dk_call% dk_depend curl.exe
rem	%dk_call% dk_debug "curl.exe = %curl.exe%"
rem	%dk_start% "%curl.exe:/=\%" --version
	
	echo.
	echo ###### Test %%dk_call%% curl.exe ######
	set "curl.exe="
	%dk_call% curl.exe --version
	
rem	echo.
rem	echo ###### Test %%curl.exe%% ######
rem	"%curl.exe:/=\%" --version
	
	echo.
	echo ###### Test %%curl.exe%% -w ######
	set command="%curl.exe:/=\%" --silent --output nul -w"
	
rem	set command=%command%certs                   = %%{certs}\n
rem	set command=%command%conn_id                 = %%{conn_id}\n
	set command=%command%content_type            = %%{content_type}\n
rem	set command=%command%errormsg                = %%{errormsg}\n
rem	set command=%command%exitcode                = %%{exitcode}\n
	set command=%command%filename_effective      = %%{filename_effective}\n
	set command=%command%ftp_entry_path          = %%{ftp_entry_path}\n
rem	set command=%command%header{name}            = %%{header{name}}\n
rem	set command=%command%header_json             = %%{header_json}\n
	set command=%command%http_code               = %%{http_code}\n
	set command=%command%http_connect            = %%{http_connect}\n
	set command=%command%http_version            = %%{http_version}\n
rem	set command=%command%json                    = %%{json}\n
	set command=%command%local_ip                = %%{local_ip}\n
	set command=%command%local_port              = %%{local_port}\n
rem	set command=%command%num_certs               = %%{num_certs}\n
	set command=%command%num_connects            = %%{num_connects}\n
rem	set command=%command%num_headers             = %%{num_headers}\n
	set command=%command%num_redirects           = %%{num_redirects}\n
rem	set command=%command%num_retries             = %%{num_retries}\n
rem	set command=%command%onerror                 = %%{onerror}\n     			&rem 7.75.0
rem	set command=%command%output{filename}        = %%{output{filename}}\n
	set command=%command%proxy_ssl_verify_result = %%{proxy_ssl_verify_result}\n
rem	set command=%command%proxy_used              = %%{proxy_used}\n
	set command=%command%redirect_url            = %%{redirect_url}\n
rem	set command=%command%referer                 = %%{referer}\n
	set command=%command%remote_ip               = %%{remote_ip}\n
	set command=%command%remote_port             = %%{remote_port}\n
	set command=%command%response_code           = %%{response_code}\n
	set command=%command%scheme                  = %%{scheme}\n
rem	set command=%command%size_delivered          = %%{size_delivered}\n
	set command=%command%size_download           = %%{size_download}\n
	set command=%command%size_header             = %%{size_header}\n
	set command=%command%size_request            = %%{size_request}\n
	set command=%command%size_upload             = %%{size_upload}\n
	set command=%command%speed_download          = %%{speed_download}\n
	set command=%command%speed_upload            = %%{speed_upload}\n
	set command=%command%ssl_verify_result       = %%{ssl_verify_result}\n
rem	set command=%command%stderr                  = %%{stderr}\n
rem	set command=%command%stdout                  = %%{stdout}\n
rem	set command=%command%time{format}            = %%{time{format}}\n
	set command=%command%time_appconnect         = %%{time_appconnect}\n
	set command=%command%time_connect            = %%{time_connect}\n
	set command=%command%time_namelookup         = %%{time_namelookup}\n
rem	set command=%command%time_posttransfer       = %%{time_posttransfer}\n
	set command=%command%time_pretransfer        = %%{time_pretransfer}\n
rem	set command=%command%time_queue              = %%{time_queue}\n
	set command=%command%time_redirect           = %%{time_redirect}\n
	set command=%command%time_starttransfer      = %%{time_starttransfer}\n
	set command=%command%time_total              = %%{time_total}\n
rem	set command=%command%tls_earlydata           = %%{tls_earlydata}\n
rem	set command=%command%url                     = %%{url}\n
rem	set command=%command%url.scheme              = %%{url.scheme}\n
rem	set command=%command%url.user                = %%{url.user}\n
rem	set command=%command%url.password            = %%{url.password}\n
rem	set command=%command%url.options             = %%{url.options}\n
rem	set command=%command%url.host                = %%{url.host}\n
rem	set command=%command%url.port                = %%{url.port}\n
rem	set command=%command%url.path                = %%{url.path}\n
		
	set command=%command%" file:///C:/Windows/System32/cmd.exe
	rem echo %command%
	%command%
%endfunction%
