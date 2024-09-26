@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if not defined BACKUP_DL_SERVER       set "BACKUP_DL_SERVER=http://aquawicket.com/download"
if not defined TEST_BACKUP_DL_SERVER  set "TEST_BACKUP_DL_SERVER=0"
::####################################################################
::# dk_download(url, destination)
::#
::#
:dk_download
    call dk_debugFunc 1 2
 setlocal
 
    set "url=%~1"
    ::%dk_call% dk_printVar url
    
    set "destination=%~2"
    ::%dk_call% dk_printVar destination
    
    %dk_call% dk_basename "%url%" url_filename
    ::%dk_call% dk_printVar url_filename
    if not defined url_filename %dk_call% dk_error "url_filename invalid"
    
    if defined destination %dk_call% dk_realpath "%destination%" destination
    ::%dk_call% dk_printVar destination
    
	call dk_validate DKDOWNLOAD_DIR "call dk_DKDOWNLOAD_DIR"
    %dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    ::%dk_call% dk_printVar DKDOWNLOAD_DIR

    if not defined destination set "destination=%DKDOWNLOAD_DIR%\%url_filename%"
    ::%dk_call% dk_printVar destination

    if not defined destination %dk_call% dk_error "destination is invalid"
    ::%dk_call% dk_printVar destination
    
    %dk_call% dk_isDirectory "%destination%" && set "destination=%destination%\%url_filename%"
    ::%dk_call% dk_printVar destination
    
    if exist "%destination%" %dk_call% dk_info "%destination% already exist" & %return%
    
	:: Test that url exists, if not try BACKUP_DL_SERVER
	if "%TEST_BACKUP_DL_SERVER%"=="1"  set "url=%BACKUP_DL_SERVER%/%url_filename%"
    %dk_call% dk_urlExists "%url%" || %dk_call% dk_warning "url:%url% NOT FOUND" && set "url=%BACKUP_DL_SERVER%/%url_filename%" && %dk_call% dk_info "Trying Backup Server url:%url% . . ."
    %dk_call% dk_urlExists "%url%" || %dk_call% dk_error "url:%url% NOT FOUND"
    %dk_call% dk_info "Downloading %url%"
    
    :: make sure the destination parent directory exists
    %dk_call% dk_dirname "%destination%" destination_dir
    ::%dk_call% dk_printVar destination_dir
    
    if not defined destination_dir %dk_call% dk_error "destination_dir is invalid"
    if not exist "%destination_dir%" %dk_call% dk_makeDirectory "%destination_dir%"

    
    ::set "DISABLE_powershell=1"
    ::set "DISABLE_curl=1"
    ::set "DISABLE_certutil=1"
    
    goto:end_dk_powershell_dl
    :: Try dk_powershell
    :dk_powershell_dl
    if defined DISABLE_dk_powershell goto:end_dk_powershell_dl
    if not defined POWERSHELL_EXE goto:end_dk_powershell_dl
    %dk_call% dk_echo "Downloading via dk_powershell"
    set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
    if not exist "%destination%_DOWNLOADING" %dk_call% dk_powershell "$cli = New-Object System.Net.WebClient; "^
        "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
        "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto:download_done
    :end_dk_powershell_dl
    
    :: Try powershell
    :powershell_dl
    if defined DISABLE_powershell goto:end_powershell_dl
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    %dk_call% dk_echo "Downloading via powershell"
    set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
    if not exist "%destination%_DOWNLOADING" %POWERSHELL_EXE% -Command "$cli = New-Object System.Net.WebClient; "^
        "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
        "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto:download_done
    :end_powershell_dl
    
    :: Try curl
    :curl_dl
    if defined DISABLE_curl goto:end_curl_dl
    %dk_call% dk_echo "Downloading via dk_curl"
    if not exist "%destination%_DOWNLOADING" curl --help %NO_STD% && curl -L "%url%" -o "%destination%_DOWNLOADING"
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto:download_done
    :end_curl_dl
    
    :: Try certutil
    :certitil_dl
    if defined DISABLE_certutil goto:end_certutil_dl
    %dk_call% dk_echo "Downloading via certutil"
    if not exist "%destination%_DOWNLOADING" certutil.exe %NO_STD% && certutil.exe -urlcache -split -f "%url%" "%destination%_DOWNLOADING"
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto:download_done
    :end_certutil_dl
    
    :download_done
    :: If Dowload Failed
    if not exist "%destination%_DOWNLOADING" %dk_call% dk_error "url:%url% DOWNLOAD FAILED"
    
    :: downloaded as temporary name like myFile.txt_DOWNLOADING
    :: then rename it to it's original upon completion
    %dk_call% dk_rename "%destination%_DOWNLOADING" "%destination%"
    if not exist "%destination%" %dk_call% dk_error "failed to rename %destination%_DOWNLOADING"
    
    %dk_call% dk_log SUCCESS "Download complete"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd"
    ::%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "DKBuilder.cmd"
    ::%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "%DKDOWNLOAD_DIR%\dk_download_batch_test\DKBuilder.cmd"
%endfunction%
