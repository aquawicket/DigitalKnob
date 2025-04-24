<<<<<<< HEAD
@echo off

if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
if not defined BACKUP_DL_SERVER       set "BACKUP_DL_SERVER=http://aquawicket.com/download"
if not defined TEST_BACKUP_DL_SERVER  set "TEST_BACKUP_DL_SERVER=0"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

if not defined dk_download_BACKUP_SERVER		(set "dk_download_BACKUP_SERVER=http://aquawicket.com/download")
if not defined dk_download_BACKUP_SERVER_TEST	(set "dk_download_BACKUP_SERVER_TEST=0")
>>>>>>> Development
::####################################################################
::# dk_download(url, destination)
::#
::#
:dk_download
<<<<<<< HEAD
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
    
    %dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
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
=======
setlocal
	%dk_call% dk_debugFunc 1 2
    
    set "url=%~1"
    set "destination=%~2"
    
    %dk_call% dk_basename "%url%"
	%dk_call% dk_assertVar dk_basename

    if defined destination (%dk_call% dk_realpath "%destination%" destination)
   
    %dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	if not defined destination (set "destination=%DKDOWNLOAD_DIR%/%dk_basename%")
	%dk_call% dk_assertVar destination
    
	%dk_call% dk_isDirectory "%destination%" && set "destination=%destination%/%dk_basename%"
    if exist "%destination%" (%dk_call% dk_info "%destination% already exist" & %return%)
 
	if "%dk_download_BACKUP_SERVER_TEST%" equ "1"  (set "url=%dk_download_BACKUP_SERVER%/%dk_basename%")
	
	::### Test that url exists, if not try dk_download_BACKUP_SERVER ###
    %dk_call% dk_urlExists "%url%" || %dk_call% dk_warning "url:%url% NOT FOUND" && set "url=%dk_download_BACKUP_SERVER%/%dk_basename%" && %dk_call% dk_info "Trying Backup Server url:%url% . . ."
    %dk_call% dk_urlExists "%url%" || %dk_call% dk_error "url:%url% NOT FOUND"
    %dk_call% dk_echo "Downloading %url%"
    
    ::### make sure the destination parent directory exists ###
    %dk_call% dk_dirname "%destination%"
    if not exist "%dk_dirname%" (%dk_call% dk_mkdir "%dk_dirname%")
>>>>>>> Development

    
    ::set "DISABLE_powershell=1"
    ::set "DISABLE_curl=1"
    ::set "DISABLE_certutil=1"
<<<<<<< HEAD
    
    goto end_dk_powershell_dl
    :: Try dk_powershell
    :dk_powershell_dl
    if defined DISABLE_dk_powershell goto end_dk_powershell_dl
    if not defined POWERSHELL_EXE goto end_dk_powershell_dl
    %dk_call% dk_echo "Downloading via dk_powershell"
    set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
    if not exist "%destination%_DOWNLOADING" %dk_call% dk_powershell "$cli = New-Object System.Net.WebClient; "^
        "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
        "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto download_done
    :end_dk_powershell_dl
    
    :: Try powershell
    :powershell_dl
    if defined DISABLE_powershell goto end_powershell_dl
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    %dk_call% dk_echo "Downloading via powershell"
=======
	
::    goto end_dk_powershell_dl
::    :: Try dk_powershell
::    :dk_powershell_dl
::    if defined DISABLE_dk_powershell goto end_dk_powershell_dl
::    if not defined POWERSHELL_EXE goto end_dk_powershell_dl
::    %dk_call% dk_echo "Downloading via dk_powershell"
::    set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
::    if not exist "%destination%_DOWNLOADING" %dk_call% dk_powershell "$cli = New-Object System.Net.WebClient; "^
::        "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
::        "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
::    %dk_call% dk_fileSize "%destination%_DOWNLOADING" fileSize
::    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
::    if exist "%destination%_DOWNLOADING" goto download_done
::    :end_dk_powershell_dl
    
    :: Try powershell
    :powershell_dl
    if defined DISABLE_powershell (goto end_powershell_dl)
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    %dk_call% dk_log DEBUG "Downloading via powershell"
>>>>>>> Development
    set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
    if not exist "%destination%_DOWNLOADING" %POWERSHELL_EXE% -Command "$cli = New-Object System.Net.WebClient; "^
        "$cli.Headers['User-Agent'] = '%User-Agent%'; "^
        "$cli.DownloadFile('%url%', '%destination%_DOWNLOADING');"
<<<<<<< HEAD
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto download_done
=======
    %dk_call% dk_fileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" (%dk_call% dk_delete "%destination%_DOWNLOADING")
    if exist "%destination%_DOWNLOADING" (goto download_done)
>>>>>>> Development
    :end_powershell_dl
    
    :: Try curl
    :curl_dl
<<<<<<< HEAD
    if defined DISABLE_curl goto end_curl_dl
    %dk_call% dk_echo "Downloading via dk_curl"
    if not exist "%destination%_DOWNLOADING" curl --help %NO_OUTPUT% && curl -L "%url%" -o "%destination%_DOWNLOADING"
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto download_done
=======
    if defined DISABLE_curl (goto end_curl_dl)
    %dk_call% dk_log DEBUG "Downloading via dk_curl"
	%dk_call% dk_validate CURL_EXE "dk_CURL_EXE"
    if not exist "%destination%_DOWNLOADING" (%CURL_EXE% --help %NO_OUTPUT% && curl -L "%url%" -o "%destination%_DOWNLOADING")
    %dk_call% dk_fileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" (%dk_call% dk_delete "%destination%_DOWNLOADING")
    if exist "%destination%_DOWNLOADING" (goto download_done)
>>>>>>> Development
    :end_curl_dl
    
    :: Try certutil
    :certitil_dl
<<<<<<< HEAD
    if defined DISABLE_certutil goto end_certutil_dl
    %dk_call% dk_echo "Downloading via certutil"
    if not exist "%destination%_DOWNLOADING" certutil.exe %NO_OUTPUT% && certutil.exe -urlcache -split -f "%url%" "%destination%_DOWNLOADING"
    %dk_call% dk_getFileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" %dk_call% dk_delete "%destination%_DOWNLOADING"
    if exist "%destination%_DOWNLOADING" goto download_done
=======
    if defined DISABLE_certutil (goto end_certutil_dl)
    %dk_call% dk_log DEBUG "Downloading via certutil"
    if not exist "%destination%_DOWNLOADING" (certutil.exe %NO_OUTPUT% && certutil.exe -urlcache -split -f "%url%" "%destination%_DOWNLOADING")
    %dk_call% dk_fileSize "%destination%_DOWNLOADING" fileSize
    if "%fileSize%" equ "0" (%dk_call% dk_delete "%destination%_DOWNLOADING")
    if exist "%destination%_DOWNLOADING" (goto download_done)
>>>>>>> Development
    :end_certutil_dl
    
    :download_done
    :: If Dowload Failed
<<<<<<< HEAD
    if not exist "%destination%_DOWNLOADING" %dk_call% dk_error "url:%url% DOWNLOAD FAILED"
=======
    if not exist "%destination%_DOWNLOADING" (%dk_call% dk_error "url:%url% DOWNLOAD FAILED")
>>>>>>> Development
    
    :: downloaded as temporary name like myFile.txt_DOWNLOADING
    :: then rename it to it's original upon completion
    %dk_call% dk_rename "%destination%_DOWNLOADING" "%destination%"
<<<<<<< HEAD
    if not exist "%destination%" %dk_call% dk_error "failed to rename %destination%_DOWNLOADING"
=======
    if not exist "%destination%" (%dk_call% dk_error "failed to rename %destination%_DOWNLOADING")
>>>>>>> Development
    
    %dk_call% dk_log SUCCESS "Download complete"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd"
    ::%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "DKBuilder.cmd"
    ::%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "%DKDOWNLOAD_DIR%\dk_download_batch_test\DKBuilder.cmd"
=======
setlocal
	%dk_call% dk_debugFunc 0

    ::%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd"
    ::%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "DKBuilder.cmd"
    ::%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd" "%DKDOWNLOAD_DIR%/dk_download_batch_test/DKBuilder.cmd"
	%dk_call% dk_download "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"
	
	%dk_call% dk_download "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip" 
>>>>>>> Development
%endfunction%
