@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_download(url, destination)
::#
::#
:dk_download
	call dk_debugFunc 1 2
	
	set "url=%~1"
	::%dk_call% dk_printVar url
	
	set "destination=%~2"
	::%dk_call% dk_printVar destination
	
	%dk_call% dk_basename "%url%" url_filename
	::%dk_call% dk_printVar url_filename
	if not defined url_filename %dk_call% dk_error "url_filename invalid"
	
	if defined destination %dk_call% dk_realpath "%destination%" destination
	::%dk_call% dk_printVar destination
	
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_setDKDOWNLOAD_DIR"
	::%dk_call% dk_printVar DKDOWNLOAD_DIR
	
	if not defined destination set "destination=%DKDOWNLOAD_DIR%\%url_filename%"
	::%dk_call% dk_printVar destination
	
	if not defined destination %dk_call% dk_error "destination is invalid"
	::%dk_call% dk_printVar destination
	
	%dk_call% dk_isDirectory "%destination%" && set "destination=%destination%\%url_filename%"
	::%dk_call% dk_printVar destination
	
    if exist "%destination%" %dk_call% dk_info "%destination% already exist" & goto:eof
	
	%dk_call% dk_info "Downloading %url_filename% . . ."
    
	:: make sure the destination parent directory exists
	%dk_call% dk_dirname "%destination%" destination_dir
	::%dk_call% dk_printVar destination_dir
	
	if not defined destination_dir %dk_call% dk_error "destination_dir is invalid"
	if not exist "%destination_dir%" %dk_call% dk_makeDirectory "%destination_dir%"
	
	set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
    
	:: Try dk_powershellEval
	if not exist "%destination%_DOWNLOADING" dk_powershellEval ^
        "$cli = New-Object System.Net.WebClient; "^
	    "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
	    "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
		
	:: Try powershell
	if not exist "%destination%_DOWNLOADING" powershell -Command ^
        "$cli = New-Object System.Net.WebClient; "^
	    "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
	    "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
		
	:: Try curl
	if not exist "%destination%_DOWNLOADING" curl --help 1>nul && curl "%url%" -o "%destination%_DOWNLOADING"
	
	:: Try certutil
	if not exist "%destination%_DOWNLOADING" certutil.exe /? 1>nul && certutil.exe -urlcache -split -f "%url%" "%destination%_DOWNLOADING"
	
	:: download as temporary name like myFile.txt_DOWNLOADING
	:: then rename it to it's original upon completion
	if not exist "%destination%_DOWNLOADING" %dk_call% dk_error "failed to download %DL_FILE%"
	
	%dk_call% dk_rename "%destination%_DOWNLOADING" "%destination%"
	
	if not exist "%destination%" %dk_call% dk_error "failed to rename %destination%_DOWNLOADING"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd"
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "DKBuilder.cmd"
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "%DKDOWNLOAD_DIR%\dk_download_batch_test\DKBuilder.cmd"
goto:eof
