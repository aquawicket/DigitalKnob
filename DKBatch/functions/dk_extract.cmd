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
rem # dk_extract(<filepath>, <target>:OPTIONAL)
rem #
rem #
:dk_extract
%setlocal%
    echo %~n0 %*
    
	rem for /F %%G IN ("%~1") do set "dk_extract_file=%%~G"
	rem for /F %%G IN ("%~2") do set "dk_extract_dest=%%~G"
	set "dk_extract_file=%~1"
	set "dk_extract_dest=%~2"
	rem set "dk_extract_file=%dk_extract_file:\=/%"
	rem set "dk_extract_dest=%dk_extract_dest:\=/%"

	rem %dk_call% dk_assertPath "%dk_extract_file%"

	rem ###### validate destination ######
    rem ## if the destination isn't provided, we should extract to a folder named the same as the file
    rem ## in the same diretory the archive file is in.
	if NOT DEFINED dk_extract_dest (
		%dk_call% dk_basename "%dk_extract_file%"
		%dk_call% dk_removeExtension "!dk_basename!"

		rem extract contents to same directoy
		%dk_call% dk_dirname "%dk_extract_file%"

		rem extract contents to folder within same directory		
		set "dk_extract_dest=!dk_dirname!/!dk_removeExtension!"
	)
	
	if EXIST "%dk_extract_dest%" (
        %dk_call% dk_isEmptyDirectory "%dk_extract_dest%" && (echo dk_isEmptyDirectory = true) || (echo dk_isEmptyDirectory = false)
        %dk_call% dk_isEmptyDirectory "%dk_extract_dest%" && (%dk_call% dk_delete "%dk_extract_dest%")
    )
	if EXIST "%dk_extract_dest%" (%dk_call% dk_error "%dk_extract_dest:/=\% already exists")

	%dk_call% dk_info "Extracting '%dk_extract_file%' to '%dk_extract_dest%' . . ."

    rem ###### Try bsdtar ###### 
    if NOT EXIST "%dk_extract_dest%" (
		%dk_call% bsdtar.exe --version && (
			%dk_call% dk_mkdir "%dk_extract_dest%"
			%dk_call% bsdtar.exe -xf "%dk_extract_file:\=/%" -C "%dk_extract_dest:\=/%"
		)
	)

    rem ###### Try powershell.exe [System.IO.Compression.ZipFile]::ExtractToDirectory ######
    if EXIST "%dk_extract_dest%" (
        %dk_call% dk_isEmptyDirectory "%dk_extract_dest%" && (%dk_call% dk_delete "%dk_extract_dest%")
    )
	if NOT EXIST "%dk_extract_dest%" (
		rem %dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
		%ComSpec% /c %dk_call% dk_findFile powershell.exe
		if EXIST "!powershell.exe!" (
			%dk_call% powershell.exe Add-Type -Assembly 'System.IO.Compression.Filesystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory^('%dk_extract_file%', '%dk_extract_dest%'^)
		)
	)

	rem ###### Try dk_callDKPowershell ######
	if EXIST "%dk_extract_dest%" (
        %dk_call% dk_isEmptyDirectory "%dk_extract_dest%" && (%dk_call% dk_delete "%dk_extract_dest%")
    )
	if NOT EXIST "%dk_extract_dest%" (
    if EXIST "!powershell.exe!" (
		%dk_call% dk_callDKPowershell dk_extract "%dk_extract_file%" "%dk_extract_dest%"
		)
	)

	rem ###### Try dk_evalPowershell Expand-Archive *** VERY SLOW *** ######
	if EXIST "%dk_extract_dest%" (
        %dk_call% dk_isEmptyDirectory "%dk_extract_dest%" && (%dk_call% dk_delete "%dk_extract_dest%")
    )
	if NOT EXIST "%dk_extract_dest%" (
    if EXIST "!powershell.exe!" (
      %dk_call% dk_evalPowershell Expand-Archive '"%dk_extract_file%"' -DestinationPath '"%dk_extract_dest%"'
		)
	)
echo 82
	rem ###### Try vbs ######
	if EXIST "%dk_extract_dest%" (
        %dk_call% dk_isEmptyDirectory "%dk_extract_dest%" && (%dk_call% dk_delete "%dk_extract_dest%")
    )
	if NOT EXIST "%dk_extract_dest%" (
        %dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
        >"!DKCACHE_DIR!/extract.vbs" (
            echo.'##################################################################################
            echo.'# extract(ZipFile, ExtractTo^)
            echo.'#
            echo.public function extract(ZipFile, ExtractTo^)
            echo.    Dim fso, objShell, FilesInZip
            echo.    Set fso = CreateObject("Scripting.FileSystemObject"^)
            echo.    If Not fso.FolderExists(ExtractTo^) Then
            echo.        fso.CreateFolder(ExtractTo^)
            echo.    End If
            echo.    Set objShell = CreateObject("Shell.Application"^)
            echo.    Set FilesInZip = objShell.NameSpace(ZipFile^).items
            echo.    objShell.NameSpace(ExtractTo^).CopyHere FilesInZip, 16
            echo.    Set fso = Nothing
            echo.    Set objShell = Nothing
            echo.    Set FilesInZip = Nothing
            echo.    WScript.Echo "Extraction complete!"
            echo.end function
            echo.
            echo.extract "%dk_extract_file:/=\%", "%dk_extract_dest:/=\%"
        )    
        %dk_call% dk_validate cscript.exe   %dk_call% dk_findFile cscript.exe
        "!cscript.exe:/=\!" //D //E:vbscript //X //NoLogo "!DKCACHE_DIR:/=\!\extract.vbs"
        %dk_call% dk_delete "!DKCACHE_DIR!/extract.vbs"
    )

    if EXIST "%dk_extract_dest%" (
        %dk_call% dk_isEmptyDirectory "%dk_extract_dest%" && (%dk_call% dk_delete "%dk_extract_dest%")
    )
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_extract "%USERPROFILE:\=/%/Digital Knob/download/cmake-3.29.5-windows-x86_64.zip" "%USERPROFILE:\=/%/Digital Knob/download/cmake-3.29.5-windows-x86_64.zip_EXTRACTED"
%endfunction%
	
    %dk_call% dk_selectFile
    %dk_call% dk_extract "%dk_selectFile%"
%endfunction%
