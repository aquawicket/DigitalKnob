@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_basename
call dk_source dk_getDKPaths
call dk_source dk_info
call dk_source dk_realpath
call dk_source dk_validate
::####################################################################
::# dk_download(url, destination)
::#
::#
:dk_download
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	
	set "url=%~1"
	set "destination=%~2"
	
	if defined destination goto:destination_set
	    call dk_basename "%url%" DL_FILE
	    call dk_validate DKDOWNLOAD_DIR "call dk_getDKPaths"
	    set "destination=%DKDOWNLOAD_DIR%\%DL_FILE%"
	:destination_set
	
	call dk_realpath "%destination%" realpath
	if "%destination%" neq "%realpath%" call dk_error "destination is invalid: full path required"
	
    if exist "%destination%" call dk_info "%destination% already exist" && goto:eof

	call dk_info "Downloading %url% . . ."
    
	set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
    
	:: Try powershell
	if not exist "%destination%" powershell /? 1>nul && powershell -command ^
        "$cli = New-Object System.Net.WebClient; "^
	    "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
	    "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
	
	:: Try curl
	if not exist "%destination%" curl --help 1>nul && curl "%url%" -o "%destination%_DOWNLOADING"
	
	:: Try certutil
	if not exist "%destination%" certutil.exe /? 1>nul && certutil.exe -urlcache -split -f "%url%" "%destination%_DOWNLOADING"
	
	:: download as temporary name like myFile.txt_DOWNLOADING
	:: then rename it to it's original upon completion
	if not exist "%destination%_DOWNLOADING" call dk_error "failed to download %DL_FILE%"
	
	call dk_rename "%destination%_DOWNLOADING" "%destination%"
	
	if not exist "%destination%" call dk_error "failed to rename %destination%_DOWNLOADING"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_download https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd
goto:eof
