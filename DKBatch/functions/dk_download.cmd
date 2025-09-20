@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::set "dk_download_DISABLE_curl=1"
::set "dk_download_DISABLE_certutil=1"
::set "dk_download_DISABLE_bitsadmin=1"
::set "dk_download_DISABLE_powershell=1"
if NOT defined dk_download_BACKUP_SERVER		(set "dk_download_BACKUP_SERVER=http://aquawicket.com/download")
if NOT defined dk_download_BACKUP_SERVER_TEST	(set "dk_download_BACKUP_SERVER_TEST=0")
::####################################################################
::# dk_download(url, destination) OVERWRITE
::#
::#
:dk_download
%setlocal%
	%dk_call% dk_debugFunc 1 2
	
    set "url=%~1"
	::%dk_call% dk_getUrl %url% url
	::%dk_call% dk_debug "dk_getUrl = %dk_getUrl%"
	
    set "destination=%~2"	
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

    %dk_call% dk_basename "%url%"
	%dk_call% dk_assertVar dk_basename

    if defined destination (%dk_call% dk_realpath "%destination%" destination)
  
    %dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	if NOT defined destination (
		set "destination=%DKDOWNLOAD_DIR%/%dk_basename%"
	)
	%dk_call% dk_assertVar destination
   
	%dk_call% dk_isDirectory "%destination%" && set "destination=%destination%/%dk_basename%"
   
	if EXIST "%destination%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_notice "%dk_basename% file already exists. Use OVERWRITE to re-download existing files."
			endlocal & (set "dk_download=%destination%")
			%return%
		)
		%dk_call% dk_delete %destination%
	)

	if "%dk_download_BACKUP_SERVER_TEST%" equ "1" (
		set "url=%dk_download_BACKUP_SERVER%/%dk_basename%"
	)
	
	::### Test that url exists, if NOT try dk_download_BACKUP_SERVER ###
    %dk_call% dk_urlExists "%url%" || %dk_call% dk_warning "url:%url% NOT FOUND" && set "url=%dk_download_BACKUP_SERVER%/%dk_basename%" && %dk_call% dk_info "Trying Backup Server url:%url% . . ."
    %dk_call% dk_urlExists "%url%" || %dk_call% dk_error "url:%url% NOT FOUND"
    %dk_call% dk_echo "Downloading %url%"
   
    ::### make sure the destination parent directory exists ###
    %dk_call% dk_dirname "%destination%"
    if NOT EXIST "%dk_dirname%" (%dk_call% dk_mkdir "%dk_dirname%")
   
    ::####################################################################################  
	:: curl
	if NOT defined dk_download_DISABLE_curl (
		%dk_call% dk_debug "Dowloading using curl"
		set "curl_exe=C:\Windows\System32\curl.exe"
		rem %dk_call% dk_validate curl_exe "%dk_call% dk_CURL_EXE"
		rem %dk_call% dk_validate curl_exe "%dk_call% dk_depend curl"
		if NOT EXIST "%destination%_DOWNLOADING" (!curl_exe! --help %NO_OUTPUT% && !curl_exe! -L "%url%" -o "%destination%_DOWNLOADING")
		%dk_call% dk_fileSize "%destination%_DOWNLOADING"
		if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "%destination%_DOWNLOADING")
	)
	if EXIST "%destination%_DOWNLOADING" (goto download_done)
	
	:: certutil
    if NOT defined dk_download_DISABLE_certutil (
		%dk_call% dk_debug "Dowloading using certutil"
		set "certutil_exe=C:\Windows\System32\certutil.exe"
		rem %dk_call% dk_validate certutil_exe "%dk_call% dk_depend certutil"
		if NOT EXIST "%destination%_DOWNLOADING" (!certutil_exe! %NO_OUTPUT% && !certutil_exe! -urlcache -split -f "%url%" "%destination%_DOWNLOADING")
		%dk_call% dk_fileSize "%destination%_DOWNLOADING"
		if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "%destination%_DOWNLOADING")
    )
	if EXIST "%destination%_DOWNLOADING" (goto download_done)
	
	:: bitsadmin
    if NOT defined dk_download_DISABLE_bitsadmin (
		%dk_call% dk_debug "Dowloading using bitsadmin"
		set "bitsadmin_exe=%windir%\System32\bitsadmin.exe"
		%dk_call% dk_firewallAllow "!bitsadmin_exe!"
pause		
		rem %dk_call% dk_validate bitsadmin_exe "%dk_call% dk_depend bitsadmin"
		
		echo "!bitsadmin_exe!" /transfer myDownloadJob "%url%" "%destination:/=\%_DOWNLOADING"
pause
		if NOT EXIST "%destination%_DOWNLOADING" ("!bitsadmin_exe!" /transfer /Download /priority Foreground "%url%" "%destination:/=\%_DOWNLOADING")
pause
		%dk_call% dk_fileSize "%destination%_DOWNLOADING"
		if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "%destination%_DOWNLOADING")
    )
	if EXIST "%destination%_DOWNLOADING" (goto download_done)

	
    :: powershell
    if NOT defined dk_download_DISABLE_powershell (
		%dk_call% dk_debug "Dowloading using powershell"
		%dk_call% dk_validate powershell_exe "%dk_call% dk_depend powershell"
		set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
		if NOT EXIST "%destination%_DOWNLOADING" %powershell_exe% -Command "$cli = New-Object System.Net.WebClient; "^
			"$cli.Headers['User-Agent'] = '!User-Agent!'; "^
			"$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
		%dk_call% dk_fileSize "%destination%_DOWNLOADING"
		if "!dk_fileSize!" equ "0" (%dk_call% dk_delete "%destination%_DOWNLOADING")
    )
	if EXIST "%destination%_DOWNLOADING" (goto download_done)
	

    :download_done
    :: If Dowload Failed
    if NOT EXIST "%destination%_DOWNLOADING" (
		%dk_call% dk_error "url:%url% DOWNLOAD FAILED"
		%return%	
	)
   
    :: downloaded as temporary name i.e. 'myFile.txt_DOWNLOADING'
    :: then rename it to it's original upon completion
    %dk_call% dk_rename "%destination%_DOWNLOADING" "%destination%"
    if NOT EXIST "%destination%" (%dk_call% dk_error "failed to rename %destination%_DOWNLOADING")
   
    ::%dk_call% dk_log SUCCESS "Download complete"
	endlocal & (
		set "dk_download=%destination%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	
::	echo(
::	echo( ### Test Initial download
::	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd"
	
::	echo(
::	echo( ### Test NO OVERWRITE
::	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd"
	
::	echo(
::	echo( ### Test OVERWRITE
::	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
	
	echo(
	echo( ### Test dk_download_DISABLE_curl
	set "dk_download_DISABLE_curl=1"
::	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
	
	echo(
	echo( ### Test dk_download_DISABLE_certutil
	set "dk_download_DISABLE_certutil=1"
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
	
::	echo(
::	echo( ### Test dk_download_DISABLE_bitsadmin
::	set "dk_download_DISABLE_bitsadmin=1"
::	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
	
::	echo(
::	echo( ### Test dk_download_DISABLE_powershell
::	set "dk_download_DISABLE_powershell=1"
::	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "" OVERWRITE
%endfunction%
