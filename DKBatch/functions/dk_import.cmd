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


rem #########################################################################
rem # dk_import() LIBRARY APP
rem #
rem #	This is a flexable super function for importing just about anything into DigitalKnob
rem #	The idea is to provide a url or path and dk_import will do the rest. 
rem #
rem #	@url	- The online path of the .git or file to import
rem #
rem #	github GIT:	https://github.com/orginization/library.git		dkimportGit(url) #branch/tag #PATCH
rem #	github DL:	https://github.com/orginization/library			dkimportGit(url) #branch/tag #PATCH
rem #	lib url DL:	https://website.com/library.zip					dkimportDownload(url) #PATCH
rem #	exe url DL:	https://website.com/executable.exe 				dkimportDownload(url) #PATCH
rem #
rem #	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
rem #
:dk_import
rem %setlocal%
	
	%dk_call% dk_importVariables %*
	rem %dk_call% dk_importVariables PRINTVARS
	
	if not defined CURRENT_PLUGIN (
		set "CURRENT_PLUGIN=%PLUGIN%"
	)	
	
	if EXIST "!%CURRENT_PLUGIN%_Install_Path!" (
		%dk_call% dk_notice "!%CURRENT_PLUGIN%_Install_Name! already installed"
		rem %return%
	)

	if defined %CURRENT_PLUGIN%_Url (
		rem NOTE: Let's not forget that we rename some download files to better identify them. These are also the renamed files that 
		rem will be on a backup server. So when we look for the download using the original url, we will check the alternate server
		rem for the file. BUT. That file is renamed, so we need to check for the new name (${${PLUGIN}_Download_Basename}).

		%dk_call% dk_download "!%CURRENT_PLUGIN%_Url!"
		%dk_call% dk_assertVar dk_download
		set "dk_import=!dk_download!"
		
		set "%CURRENT_PLUGIN%_Download=!dk_download!"
		%dk_call% dk_assertVar %CURRENT_PLUGIN%_Download
		%dk_call% dk_getExtension "!%CURRENT_PLUGIN%_Download!" %CURRENT_PLUGIN%_Download_Extension
		
			   if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".7z" (
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".bz" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".bz2" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".gz" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".rar" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".sfx.exe" (	
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".tar" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".tar.gz" (	
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".tar.xz" (	
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".tgz" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".xz" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		) else if /i "!%CURRENT_PLUGIN%_Download_Extension!" equ ".zip" (		
			set "%CURRENT_PLUGIN%_Download_Filetype=Archive"
		)
		
		if /i "!%CURRENT_PLUGIN%_Download_Filetype!" equ "Archive" (
			%dk_call% dk_smartExtract "!%CURRENT_PLUGIN%_Download!" "!%CURRENT_PLUGIN%_Install_Path!"
		)
		
		rem ### Import from Git
		if /i "!%CURRENT_PLUGIN%_Download_Filetype!" equ "Git" (
			if NOT EXIST "%PLUGIN_Install_Path%/.git" (
				%dk_call% dk_todo "Import From Git"
				rem %dk_call% dk_gitClone "%PLUGIN_Url%" "%PLUGIN_Install_Path%"
			)
		)
		
		rem ### Import from Executable
		if /i "!%CURRENT_PLUGIN%_Download_Filetype!" equ "Executable" (
			%dk_call% dk_exec "%dk_download%"
			%dk_call% dk_todo "Import from Executable"
		)
	)
	
	rem dk_getParameter PATCH %*
	rem if defined PATCH (
	rem 		if defined %CURRENT_PLUGIN%_Import_Name if defined %CURRENT_PLUGIN%_Install_Path (
	rem			%dk_call% dk_todo "dk_patch"
rem	%dk_call% dk_copy "!%CURRENT_PLUGIN%_Import_Path!" "!%CURRENT_PLUGIN%_Install_Path!"
	rem			rem %dk_call% dk_patch "!%CURRENT_PLUGIN%_Import_Name!" "!%CURRENT_PLUGIN%_Install_Path!"
	rem		)
	rem )
	
	
	
rem	set "_SCOPE_=%~n0"
rem	for /F "tokens=* delims=" %%G in ('set %PLUGIN%') do (
rem		if "%_SCOPE_%" equ "%~n0" endlocal
rem		set "%%G"
rem		set "PLUGIN=%PLUGIN%"
rem	)
%endfunction%














rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	
	%dk_call% dk_validate git %dk_call% dk_depend git
%endfunction%