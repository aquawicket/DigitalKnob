@echo off
if "%~1" == "" (goto dk_install)

:runDKHtml

	:: TODO

%endfunction%




















:dk_install
	set "BROWSER_EXE=C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
	
    ::###### DKINIT ######
    if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\")
    if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	%dk_call% dk_assertPath DKBATCH_FUNCTIONS_DIR_
	
    ::###### Install DKHtml ######
    %dk_call% dk_echo "Installing DKHtml . . ."
	%dk_call% dk_assertPath BROWSER_EXE
    set "DKHTML_FUNCTIONS_DIR=..\DKHtml\functions"

	%dk_call% dk_registryDeleteKey "HKCR\DKHtml"
	
	set "CMD_EXE=%COMSPEC%"
	%dk_call% dk_assertPath CMD_EXE
	ftype DKHtml=%BROWSER_EXE% "%%1" %*
    %dk_call% dk_registrySetKey "HKCR\DKHtml\DefaultIcon" "" "REG_SZ" "%BROWSER_EXE%"

    %dk_call% dk_registryDeleteKey "HKCR\.html"
    %dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html"
    assoc .html=DKHtml

    %dk_call% dk_success "DKHtml install complete"
%endfunction%
