@rem shebang
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


rem ####################################################################
rem # dk_download(url, destination) OVERWRITE
rem #
:dk_download
	rem if NOT defined dk_download_DISABLE_curl		(set "dk_download_DISABLE_curl=0")
	rem if NOT defined dk_download_DISABLE_certutil	(set "dk_download_DISABLE_certutil=0")
	rem if NOT defined dk_download_DISABLE_powershell	(set "dk_download_DISABLE_powershell=0")
	if NOT defined dk_download_DISABLE_bitsadmin	(set "dk_download_DISABLE_bitsadmin=1") 
	if NOT defined dk_download_BACKUP_SERVER		(set "dk_download_BACKUP_SERVER=%DKHttp_DKDownload_Dir%")
	rem if NOT defined dk_download_BACKUP_SERVER_TEST	(set "dk_download_BACKUP_SERVER_TEST=0")
%setlocal%

    set "dk_download_url=%~1"
    set "dk_download_url=%dk_download_url:\=/%"

	rem ##### Save the url to Wayback Machine ######
	rem %dk_call% curl.exe https://web.archive.org/save/%_dk_download_url:\=/_%
	
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	rem fix infinate recursion loop
	%dk_call% dk_getUrlFilename "%dk_download_url%"

	if "%dk_download_BACKUP_SERVER_TEST%" equ "1" (set "dk_download_url=%dk_download_BACKUP_SERVER%/%dk_getUrlFilename%")
	
	rem ### Test that url exists, if NOT try dk_download_BACKUP_SERVER ###
    %dk_call% dk_urlExists "%dk_download_url%" || (
		%dk_call% dk_warning "dk_download_url:'%dk_download_url%' NOT FOUND"
		set "dk_download_url=%dk_download_BACKUP_SERVER%/%dk_getUrlFilename%"
		%dk_call% dk_info "Trying Backup Server url:'!dk_download_url!' . . ."
	)
    %dk_call% dk_urlExists "%dk_download_url%" || (
		%dk_call% dk_error "dk_download_url:'%dk_download_url%' NOT FOUND"
		goto:return
	)
	
	rem ##############################
	set "dk_download=%~2"
	if NOT defined dk_download (
    %dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
    set "dk_download=!DKDOWNLOAD_DIR!/%dk_getUrlFilename%"
  )
  set "saved_dk_download=%dk_download%"
  echo [32m saved_dk_download = '%saved_dk_download%' [0m

	%dk_call% dk_realpath "%dk_download%" dk_download
	rem %dk_call% dk_isDirectory "%dk_download%" && (set "dk_download=%dk_download%/%dk_getUrlFilename%")
	%dk_call% dk_debug "dk_download = '%dk_download%'"
	
	if EXIST "%dk_download%" (
		if "%OVERWRITE%" equ "1" (
			rem %dk_call% dk_delete "%dk_download%"
		) else (
			%dk_call% dk_notice "%dk_download% already exists. Use OVERWRITE to re-download existing files."
			goto:return
		)
	)
    rem ### make sure the dk_download parent directory exists ###
   rem %dk_call% dk_dirname "%dk_download%"
     for %%Z in ("%dk_download:/=\%") do set "dk_dirname=%%~dpZ"
	if NOT EXIST "%dk_dirname%" (
		mkdir "%dk_dirname:/=\%"
	)
	rem ##############################
	
    rem ############################### Download ####################################  
	%dk_call% dk_echo "Downloading %dk_download_url%"
	
	rem ### curl
	if NOT EXIST "%dk_download%_DOWNLOADING" (
		if "%dk_download_DISABLE_curl%" neq "1" (
			rem %dk_call% curl.exe --version 1>nul 2>nul && (
			%dk_start% "!curl.exe:/=\!" --version && (
				
				rem ############ curl options ############	 
				rem # -Z, --time-cond 				only download if server file newer than local
				rem #	-R, --remote-time 				preserve the downloaded files time-stamp
				rem #	-L, --location	 				follow redirects
				rem #	-s, --silent					Do not show progress meter or error messages. 
				rem #	-S, --show-error				When used with --silent, it makes curl show an error message if it fails.
				rem #	-o, --output <file>				Write output to the given file instead of stdout.
				rem #	-I, --head						Fetch the headers only.
				rem #	-H, --header <header/@file>		Extra header to include in information sent.
				rem #	-f, --fail						Fail with error code 22 and with no response body output
				rem # 	-w, --write-out <format>		Display information on stdout after a completed transfer.
				rem #			filename_effective		The ultimate filename that curl writes out to.
				rem #			http_code				The numerical response code that was found in the last retrieved HTTP(S) or FTP(s) transfer.
				rem #	-O, --remote-name				Write output to a local file named like the remote file we get.
				rem #	-J, --remote-header-name		Tell the --remote-name option to use the server-specified Content-Disposition filename.
				rem #       --remove-on-error 			Remove the output file if an error occurs.
				rem #	    --output-dir				Directory to download the file to
				rem #		--create-dirs				When used in conjunction with the --output option, curl creates the necessary local directory hierarchy
				rem #		--create-dirs				
				
				rem ######### Backup to Wayback Machine ############
				rem %dk_call% dk_validate DKIMPORT_DIR %dk_call% dk_DKIMPORT_DIR
				rem %dk_call% "%DKIMPORT_DIR%/waybackMachine/dk_saveUrl.cmd" %dk_download_url:\=/%
		
				if EXIST "!dk_download!" (
					                  rem %dk_call% curl.exe --show-error --time-cond "!dk_download:/=\!" --remote-time --location --create-dirs --output "!dk_download:/=\!_DOWNLOADING" %dk_download_url:\=/%
					%dk_start% "!curl.exe:/=\!" --show-error --time-cond "!dk_download:/=\!" --remote-time --location --create-dirs --output "!dk_download:/=\!_DOWNLOADING" 
				) else (
					rem %dk_call% curl.exe --show-error --remote-time --location --create-dirs --output "!dk_download:/=\!_DOWNLOADING" %dk_download_url:\=/%
					%dk_start% "!curl.exe:/=\!" --show-error --remote-time --location --create-dirs --output "!dk_download:/=\!_DOWNLOADING" %dk_download_url:\=/%
				)
				
				rem if NOT EXIST "!dk_download!_DOWNLOADING" (goto :end_download)
				
				%dk_call% dk_fileSize "!dk_download!_DOWNLOADING"
				if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "!dk_download!_DOWNLOADING")
			)
		)
	)
	
	rem ### powershell
	if NOT EXIST "%dk_download%_DOWNLOADING" (
		if "%dk_download_DISABLE_powershell%" neq "1" (
			%dk_call% dk_debug "Dowloading using powershell"
			%dk_call% dk_validate powershell.exe %dk_call% dk_findFile powershell.exe
			%dk_call% dk_firewallAllow "!powershell.exe!"
			"!powershell.exe:/=\!" -Command exit 1>nul 2>nul && (
				"!powershell.exe:/=\!" -Command "$cli = New-Object System.Net.WebClient; "^
				"$cli.Headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'; "^
				"$cli.DownloadFile('%dk_download_url%', '%dk_download%_DOWNLOADING');"
				%dk_call% dk_fileSize "%dk_download%_DOWNLOADING"
				if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "%dk_download%_DOWNLOADING")
			)
		)
    )
	
	rem ### certutil
	if NOT EXIST "%dk_download%_DOWNLOADING" (
		if "%dk_download_DISABLE_certutil%" neq "1" (
			%dk_call% dk_debug "Dowloading using certutil"
			%dk_call% dk_validate certutil.exe %dk_call% dk_findFile certutil.exe
			%dk_call% dk_firewallAllow "!certutil.exe!"
			"!certutil.exe:/=\!" 1>nul 2>nul && (
				"!certutil.exe:/=\!" -urlcache -split -f "%dk_download_url%" "%dk_download%_DOWNLOADING"
				%dk_call% dk_fileSize "%dk_download%_DOWNLOADING"
				if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "%dk_download%_DOWNLOADING")
			)
		)
	)
	
	rem ### bitsadmin
rem	if NOT EXIST "%dk_download%_DOWNLOADING" (
rem		if "%dk_download_DISABLE_bitsadmin%" neq "1" (
rem			%dk_call% dk_debug "Dowloading using bitsadmin"
rem     %dk_call% dk_validate bitsadmin.exe %dk_call% dk_findFile bitsadmin.exe
rem			%dk_call% dk_firewallAllow "!bitsadmin.exe!"
rem			"!bitsadmin.exe:/=\!" /transfer /Download /priority Foreground "%dk_download_url%" "%dk_download%_DOWNLOADING"
rem			%dk_call% dk_fileSize "%dk_download%_DOWNLOADING"
rem			if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "%dk_download%_DOWNLOADING")
rem		)
rem	)
	
    rem If Dowload Failed
    if NOT EXIST "%dk_download%_DOWNLOADING" (
		%dk_call% dk_error "dk_download_url:'%dk_download_url%' DOWNLOAD FAILED"
		goto:return	
	)
   
    rem rename temporary download filename to it's original filename
    %dk_call% dk_rename "%dk_download%_DOWNLOADING" "%dk_download%"
    if NOT EXIST "%dk_download%" (
		%dk_call% dk_error "failed to rename '%dk_download%_DOWNLOADING'"
	)
   
	rem ### return ###
	:return
	if "%dk_download%" neq "%saved_dk_download%" (
    echo [31m ERROR: dk_download:'%dk_download%' changed from '%saved_dk_download%' [0m & pause & exit/b1
	)
	
	endlocal & (
		set "dk_download=%dk_download%"
	)
	
	
	rem %dk_call% dk_log SUCCESS "Download complete"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
rem	echo.
rem	echo. ### Test Initial download
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd"
	
rem	echo.
rem	echo. ### Test NO OVERWRITE
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd"
	
rem	echo.
rem	echo. ### Test OVERWRITE
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
	
rem	echo.
rem	echo. ### Test dk_download_DISABLE_curl
rem	set "dk_download_DISABLE_curl=1"
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
	
rem	echo.
rem	echo. ### Test dk_download_DISABLE_powershell
rem	set "dk_download_DISABLE_powershell=1"
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE

rem	echo.
rem	echo. ### Test dk_download_DISABLE_certutil
rem	set "dk_download_DISABLE_certutil=1"
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
	
rem NOTE: this will roduce and error as all download methods are now turned off
rem	echo.
rem	echo. ### Test dk_download_DISABLE_bitsadmin
rem	set "dk_download_DISABLE_bitsadmin=1"
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE

rem	%dk_call% dk_download "https://go.microsoft.com/fwlink/?linkid=2289980"
rem	%dk_call% dk_echo "dk_download = %dk_download%"

rem	%dk_call% dk_assertPath "%DKStorage_Dir%"
rem	%dk_call% dk_download "http://aquawicket.com/DigitalKnob/DKStorage/DigitalKnob.bundle" "%DKStorage_Dir%/DigitalKnob.bundle" OVERWRITE
rem	%dk_call% dk_debug "dk_download = %dk_download%"
	
	rem %dk_call% dk_inputBox
	rem %dk_call% dk_download %dk_inputBox%
	%dk_call% dk_download "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"
	
%endfunction%
