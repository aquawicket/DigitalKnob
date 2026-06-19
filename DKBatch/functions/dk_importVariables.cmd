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












rem ###################################################################################################################################
rem # dk_importVariables() 
rem #
rem #	###### Options ######						############ Examples ############
rem #
rem #	BRANCH "string" (optional)					BRANCH "develop"
rem #												BRANCH "master"
rem #																
rem #	IMPORT_NAME "string" (optional)				IMPORT_NAME "zlib"
rem #
rem #	IMPORT_PATH "path" (optional)				IMPORT_PATH	"C:/Users/Administrator/Digital Knob/Development/3rdParty/_DKIMPORTS/zlib"
rem #
rem #	IMPORT_ROOT	"path" (optional)				IMPORT_ROOT	"C:/Users/Administrator/Digital Knob/Development/3rdParty/_DKIMPORTS"
rem #
rem #	INSTALL_NAME "string" (optional)			INSTALL_NAME "zlib-8-5-2025"
rem #												INSTALL_NAME "myZLIB"
rem #
rem #	INSTALL_PATH "path" (optional)				INSTALL_PATH "C:/Users/Administrator/Digital Knob/Development/DKTools/zlib-8-5-2025"
rem #												INSTALL_PATH "C:/Users/Administrator/Digital Knob/Development/DKTools/myZLIB"
rem #
rem #	INSTALL_ROOT "path "(optional)				INSTALL_ROOT "C:/Users/Administrator/Digital Knob/Development/DKTools"
rem #
rem # TAG "string" (optional)						TAG "v1.3.1.2"
rem #
rem #	URL	"url" (optional)						URL "https://github.com/madler/zlib.git"							* github repository link
rem #												URL "https://github.com/madler/zlib/archive/refs/heads/master.zip"	* github sourcecode download
rem #												URL "https://github.com/madler/zlib"        						* github page
rem #												URL "https://zlib.net/zlib-1.3.1.tar.gz"							* library sourcecode download
rem #												URL "https://website.com/executable.exe"              				* executable file
rem #
rem #	VERSION "string" (optional)					VERSION	"master"
rem #
rem #	###### SubCommands ###
rem #	
rem #	PRINTVARS  * print the current variable values of the current PLUGIN
rem #
:dk_importVariables
%setlocal%
	
	%dk_call% dk_getParameterValue PRINTVARS %*
	if defined PRINTVARS (
		%dk_call% dk_unset PRINTVARS
		call :PRINTVARS
		%return%
	)
																	rem ###### EXAMPLE ######
	rem ### IMPORT_PATH (PLUGIN_Import_Path)							/c/Users/Administrator/Digital Knob/Development/3rdParty/_DKIMPORTS/zlib
	%dk_call% dk_unset IMPORT_PATH
	%dk_call% dk_getParameterValue IMPORT_PATH %*
	
	rem ### PLUGIN_Args												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	%dk_call% dk_unset ARGS
	set ARGS=%*
	
	rem ### IMPORT_ROOT (PLUGIN_Import_Dirname)						/c/Users/Administrator/Digital Knob/Development/3rdParty/_DKIMPORTS
	%dk_call% dk_unset IMPORT_ROOT
	%dk_call% dk_getParameterValue IMPORT_ROOT %*
	
	rem ### IMPORT_NAME (PLUGIN_Import_Name)							zlib
	%dk_call% dk_unset IMPORT_NAME
	%dk_call% dk_getParameterValue IMPORT_NAME %*

	rem ### INSTALL_ROOT (PLUGIN_Install_Dirname)						/c/Users/Administrator/Digital Knob/Development/3rdParty
	%dk_call% dk_unset INSTALL_ROOT
	%dk_call% dk_getParameterValue INSTALL_ROOT %*

	rem ### INSTALL_NAME (PLUGIN_Install_Name)						zlib-master
	%dk_call% dk_unset INSTALL_NAME
	%dk_call% dk_getParameterValue INSTALL_NAME %*

	rem ### INSTALL_PATH (PLUGIN_Install_Path)						/c/Users/Administrator/Digital Knob/Development/3rdParty/zlib-master
	%dk_call% dk_unset INSTALL_PATH
	%dk_call% dk_getParameterValue INSTALL_PATH %*

	rem ### VERSION (PLUGIN_Version)									v1.3.1
	%dk_call% dk_unset VERSION
	%dk_call% dk_getParameterValue VERSION %*

	rem ### BRANCH (PLUGIN_Branch)									master
	%dk_call% dk_unset BRANCH
	%dk_call% dk_getParameterValue BRANCH	%*
	
	rem ### TAG (PLUGIN_Tag)											v1.3.1.2
	%dk_call% dk_unset TAG
	%dk_call% dk_getParameterValue TAG	%*

	rem ### URL														"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	%dk_call% dk_unset URL
	%dk_call% dk_getParameterValue URL	%*
	
	rem ### PLUGIN_ vars
	%dk_call% dk_unset PLUGIN
	call :PLUGIN
	call :PLUGIN_DKConfig
	rem call :PLUGIN_Import_Path
	call :PLUGIN_Id
	rem call :PLUGIN_Args
	rem call :PLUGIN_Url
	rem call :PLUGIN_Url_Basename
	rem call :PLUGIN_Url_Name
	rem call :PLUGIN_Url_Extension
	rem call :PLUGIN_Import_Dirname
	rem call :PLUGIN_Import_Name
	rem call :PLUGIN_Tuple_Dir
	rem call :PLUGIN_Build_Dir
	rem call :PLUGIN_Config_Dir
	rem call :PLUGIN_Debug_Dir
	rem call :PLUGIN_Release_Dir
	rem call :PLUGIN_Version
	call :PLUGIN_Download
	rem call :PLUGIN_Download_Basename
	rem call :PLUGIN_Install_Dirname
	rem call :PLUGIN_Install_Name
	call :PLUGIN_Install_Path	
	
	rem ### %PLUGIN%
	set "%PLUGIN%=!%PLUGIN%_Install_Path!"
	%dk_call% dk_debug "PLUGIN = '%PLUGIN%'"
	
	rem #####################################################
	rem ############# PLUGIN Target_Directries ##############
	rem #####################################################

	rem ### PLUGIN_Tuple_Dir											C:/Users/Administrator/Digital Knob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	if defined Target_Tuple (
		set "%PLUGIN%_Tuple_Dir=!%PLUGIN%_Install_Path!/%Target_Tuple%"
		%dk_call% dk_debug "%PLUGIN%_Tuple_Dir = '!%PLUGIN%_Tuple_Dir!'"
	)

	rem ### PLUGIN_Config_Dir											C:/Users/Administrator/Digital Knob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	if defined Config_Path (
		rem set "PLUGIN_Config_Dir=%PLUGIN_Install_Path%/%Config_Path%"
		set "%PLUGIN%_Config_Dir=!%PLUGIN%_Install_Path!/%Target_Config%"
		%dk_call% dk_debug "%PLUGIN%_Config_Dir = '!%PLUGIN%_Config_Dir!'"
	)
	
	rem ### PLUGIN_Build_Dir											C:/Users/Administrator/Digital Knob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	if defined Build_Path (
		rem set "PLUGIN_Build_Dir=%PLUGIN_Install_Path%/%Build_Path%"
		set "%PLUGIN%_Build_Dir=!%PLUGIN%_Install_Path!/%Target_Build%"
		%dk_call% dk_debug "%PLUGIN%_Build_Dir = '!%PLUGIN%_Build_Dir!'"
	)
	
	rem ### PLUGIN_Debug_Dir											C:/Users/Administrator/Digital Knob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	if defined Debug_Dir (
		set "%PLUGIN%_Debug_Dir=!%PLUGIN%_Tuple_Dir!/%Debug_Dir%"
		%dk_call% dk_debug "%PLUGIN%_Debug_Dir = '!%PLUGIN%_Debug_Dir!'"
	)
	
	rem ### PLUGIN_Release_Dir										C:/Users/Administrator/Digital Knob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	if defined Release_Dir (
		set "%PLUGIN%_Release_Dir=!%PLUGIN%_Tuple_Dir!/%Release_Dir%"
		%dk_call% dk_debug "%PLUGIN%_Release_Dir = '!%PLUGIN%_Release_Dir!'"
	)
	
	rem ### Set the <PLUGIN_Id> variable to mirror %PLUGIN%
	rem ### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	set "_SCOPE_=%~n0"
	for /F "tokens=* delims=" %%G in ('set %PLUGIN%') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%G"
		set "PLUGIN=%PLUGIN%"
	)
	
	%dk_call% dk_debug "%PLUGIN% = '!%PLUGIN%!'"
	rem call :PRINTVARS
%endfunction%


rem ##################################
:PLUGIN_DKConfig
	if defined %PLUGIN%_DKConfig (%return%)

	call :PLUGIN_Import_Path
	if defined %PLUGIN%_Import_Path (
		set "%PLUGIN%_DKConfig=!%PLUGIN%_Import_Path!/dkconfig.txt"
	)
	
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	
	%dk_call% dk_assertVar DKHTTP_DIGITALKNOB_DIR
	rem %dk_call% dk_validate DKHTTP_DIGITALKNOB_DIR %dk_call% dk_DKHTTP_DIGITALKNOB_DIR
	
	if NOT EXIST "!%PLUGIN%_DKConfig!" (
		set "%PLUGIN%_DKHTTP_DKConfig=!%PLUGIN%_DKConfig:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%!"
		%dk_call% dk_download "!%PLUGIN%_DKHTTP_DKConfig!" "!%PLUGIN%_DKConfig!"
	)
	
	:return
	if NOT EXIST "!%PLUGIN%_DKConfig!" (
		%dk_call% dk_notice "%PLUGIN%_DKConfig:'!%PLUGIN%_DKConfig!' NOT FOUND"
	)
	%dk_call% dk_debug "%PLUGIN%_DKConfig = '!%PLUGIN%_DKConfig!'"
%endfunction%	
	
rem #####################
:PLUGIN_Type
	if defined %PLUGIN%_Type (%return%)
	
	call :PLUGIN_DKConfig
	if defined %PLUGIN%_DKConfig (
		%dk_call% dk_fileVariables "!%PLUGIN%_DKConfig!"
	)
	
	:return
	if NOT defined %PLUGIN%_Type (
		%dk_call% dk_notice "%PLUGIN%_Type:'!%PLUGIN%_Type!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Type = '!%PLUGIN%_Type!'"	
%endfunction%

rem ##################################
:PLUGIN_Import
	if defined %PLUGIN%_Import (%return%)
	
	call :PLUGIN_DKConfig
	if defined %PLUGIN%_DKConfig (echo. 1>nul) else (goto:else_dkconfig)

		%dk_call% dk_fileVariables "!%PLUGIN%_DKConfig!"

		rem ### <PLUGIN>_Import ###
		rem ### <PLUGIN>_Host_Tuple_Import
		%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
		if defined %PLUGIN%_%Host_Tuple%_Import (
			set "%PLUGIN%_Import=!%PLUGIN%_%Host_Tuple%_Import!"
		
		rem ### <PLUGIN>_Host_Os_Import
		) else if defined %PLUGIN%_%Host_Os%_Import (
			set "%PLUGIN%_Import=!%PLUGIN%_%Host_Os%_Import!"
			
		rem ### <PLUGIN>_Host_Arch_Import
		) else if defined %PLUGIN%_%Host_Arch%_Import (
			set "%PLUGIN%_Import=!%PLUGIN%_%Host_Arch%_Import!"
		
		rem ### <PLUGIN>_Apple_Import
		) else if defined Apple_Host (
			if defined %PLUGIN%_Apple_Import (
				set "%PLUGIN%_Import=!%PLUGIN%_Apple_Import!"
			)
		rem ### <PLUGIN>_Linux_Import
		) else if defined Linux_Host (
			if defined %PLUGIN%_Linux_Import (
				set "%PLUGIN%_Import=!%PLUGIN%_Linux_Import!"
			)
		rem ### <PLUGIN>_Unix_Import
		) else if defined Unix_Host (
			if defined %PLUGIN%_Unix_Import (
				set "%PLUGIN%_Import=!%PLUGIN%_Unix_Import!"
			)
		rem ### <PLUGIN>_Windows_Import
		) else if defined Windows_Host (
			if defined %PLUGIN%_Windows_Import (
				set "%PLUGIN%_Import=!%PLUGIN%_Windows_Import!"
			)
		rem ### default
		rem ) else if defined %PLUGIN%_Import (
			rem set "%PLUGIN%_Import=!%PLUGIN%_Import!"
			
		rem ### Import NOT FOUND	
		) else (
			%dk_call% dk_notice "No Import found for PLUGIN:'%PLUGIN%'"
		)
		
		(goto:end_dkconfig)
	:else_dkconfig
		rem %dk_call% dk_set %PLUGIN%_DKConfig ""
	:end_dkconfig
	
	:return
	if NOT defined %PLUGIN%_Import (
		%dk_call% dk_notice "%PLUGIN%_Import:'!%PLUGIN%_Import!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Import = '!%PLUGIN%_Import!'"
%endfunction%

rem #####################
:PLUGIN_Install_Dirname
	if defined %PLUGIN%_Install_Dirname (%return%)
	
	call :PLUGIN_Type
	
	if defined INSTALL_ROOT (
		set "%PLUGIN%_Install_Dirname=%INSTALL_ROOT%"
	) else if "!%PLUGIN%_Type!" equ "Tool" (
		%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
		set "%PLUGIN%_Install_Dirname=!DKTOOLS_DIR!"
	) else (
		%dk_call% dk_validate DK3RDPARTY_DIR %dk_call% dk_DK3RDPARTY_DIR
		set "%PLUGIN%_Install_Dirname=!DK3RDPARTY_DIR!"
	)
	
	:return
	if NOT defined %PLUGIN%_Install_Dirname (
		%dk_call% dk_notice "%PLUGIN%_Install_Dirname:'!%PLUGIN%_Install_Dirname!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Install_Dirname = '!%PLUGIN%_Install_Dirname!'"
%endfunction%

rem #######################
:PLUGIN_Import_Name_Lower
	if defined %PLUGIN%_Import_Name_Lower (%return%)
	
	call :PLUGIN_Import_Name
	%dk_call% dk_toLower 	"!%PLUGIN%_Import_Name!" 	%PLUGIN%_Import_Name_Lower
	
	:return
	if NOT defined %PLUGIN%_Import_Name_Lower (
		%dk_call% dk_notice "%PLUGIN%_Import_Name_Lower:'!%PLUGIN%_Import_Name_Lower!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Import_Name_Lower = '!%PLUGIN%_Import_Name_Lower!'"
%endfunction%

rem #############
:PLUGIN_Version
	if defined %PLUGIN%_Version (%return%)
		
	call :PLUGIN_Url_Name_Lower
	call :PLUGIN_Import_Name_Lower
	
	if defined VERSION (
		set "%PLUGIN%_Version=%VERSION%"
	) else if defined TAG (
		set "%PLUGIN%_Version=%TAG%"
	) else if defined BRANCH (
		set "%PLUGIN%_Version=%BRANCH%"
	) else if defined %PLUGIN%_Url_Name_Lower if defined %PLUGIN%_Import_Name_Lower (
		%dk_call% dk_replaceAll "!%PLUGIN%_Url_Name_Lower!" 	"!%PLUGIN%_Import_Name_Lower!" 	"" 	%PLUGIN%_Version
	)
	
	%dk_call% dk_trimNonAlphaNumeric "!%PLUGIN%_Version!"
	set "%PLUGIN%_Version=%dk_trimNonAlphaNumeric%"
	
	:return
	if NOT defined %PLUGIN%_Version (
		%dk_call% dk_notice "%PLUGIN%_Version:'!%PLUGIN%_Version!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Version = '!%PLUGIN%_Version!'"
%endfunction%

rem #############
:PLUGIN_Download
	if defined %PLUGIN%_Download (%return%)
		
	call :PLUGIN_Url
	if defined %PLUGIN%_Url (
		%dk_call% dk_getUrlFilename "!%PLUGIN%_Url!"
		%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
		set "%PLUGIN%_Download=!DKDOWNLOAD_DIR!/!dk_getUrlFilename!"
	)

	:return
	if NOT defined %PLUGIN%_Download (
		%dk_call% dk_notice "%PLUGIN%_Download:'!%PLUGIN%_Download!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Download = '!%PLUGIN%_Download!'"
%endfunction%

rem ##################
:PLUGIN_Install_Name
	if defined %PLUGIN%_Install_Name (%return%)
	
	call :PLUGIN_Import_Name
	call :PLUGIN_Version
	
	if defined INSTALL_NAME (
		set "%PLUGIN%_Install_Name=%INSTALL_NAME%"
	) else if defined %PLUGIN%_Import_Name (
		if defined %PLUGIN%_Version (
			set "%PLUGIN%_Install_Name=!%PLUGIN%_Import_Name!-!%PLUGIN%_Version!"
		) else (
			set "%PLUGIN%_Install_Name=!%PLUGIN%_Import_Name!"
		)
	)
	
	:return
	if NOT defined %PLUGIN%_Install_Name (
		%dk_call% dk_notice "%PLUGIN%_Install_Name:'!%PLUGIN%_Install_Name!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Install_Name = '!%PLUGIN%_Install_Name!'"
%endfunction%

rem ##################
:PLUGIN_Url_Basename
	if defined %PLUGIN%_Url_Basename (%return%)
	
	call :PLUGIN_Url
	if defined %PLUGIN%_Url (
		%dk_call% dk_basename	"!%PLUGIN%_Url!"  %PLUGIN%_Url_Basename
	)
	
	:return
	if NOT defined %PLUGIN%_Url_Basename (
		%dk_call% dk_notice "%PLUGIN%_Url_Basename:'!%PLUGIN%_Url_Basename!' UNDEFEINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Url_Basename = '!%PLUGIN%_Url_Basename!'"
%endfunction%

rem ###################
:PLUGIN_Url_Extension
	if defined %PLUGIN%_Url_Extension (%return%)
	
	call :PLUGIN_Url	
	if defined %PLUGIN%_Url (
		%dk_call% dk_dirname	"!%PLUGIN%_Url!"  %PLUGIN%_Url_Dirname
	)
	
	:return
	if NOT defined %PLUGIN%_Url_Dirname (
		%dk_call% dk_notice "%PLUGIN%_Url_Dirname:'!%PLUGIN%_Url_Dirname!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Url_Dirname = '!%PLUGIN%_Url_Dirname!'"
%endfunction%

rem #################
:PLUGIN_Import_Name
	if defined %PLUGIN%_Import_Name (%return%)
	
	rem call :PLUGIN_Import_Path
	if defined IMPORT_NAME (
		set "%PLUGIN%_Import_Name=%IMPORT_NAME%"
	) else if defined %PLUGIN%_Import_Path (
		%dk_call% dk_basename	"!%PLUGIN%_Import_Path!"	%PLUGIN%_Import_Name
	) else (
		%dk_call% dk_includes "!%PLUGIN%_Url!" "https://github.com" && (
			%dk_call% dk_replaceAll 	"!%PLUGIN%_Url!" 		"/" 	";" 	%PLUGIN%_Url_List
			%dk_call% dk_listToArray 	"!%PLUGIN%_Url_List!" %PLUGIN%_Url_Array
			%dk_call% dk_arrayAt		%PLUGIN%_Url_Array	3				%PLUGIN%_Import_Name
		) || %clearerror%
	)
	
	:return
	if NOT defined %PLUGIN%_Import_Name (
		%dk_call% dk_notice "%PLUGIN%_Import_Name:'!%PLUGIN%_Import_Name!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Import_Name = '!%PLUGIN%_Import_Name!'"
%endfunction%

rem ####################
:PLUGIN_Url
	if defined %PLUGIN%_Url (%return%)
	
	rem call :PLUGIN_Import 
	rem if defined !%PLUGIN%_Import! (
	rem 	set "%PLUGIN%_Url=!!%PLUGIN%_Import!!"
	rem )
	rem else if defined %PLUGIN%_Import (
	rem 	set "%PLUGIN%_Url=!%PLUGIN%_Import!"
	rem )
	
	call :PLUGIN_Import
	if defined %PLUGIN%_Import (
		rem %dk_call% dk_set %PLUGIN%_Url "!%PLUGIN%_Import!"
		set "%PLUGIN%_Url=!%PLUGIN%_Import!"
	)
	
	:return
	if not defined %PLUGIN%_Url (
		%dk_call% dk_notice "%PLUGIN%_Url:'!%PLUGIN%_Url!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Url = '!%PLUGIN%_Url!'"
%endfunction%

rem ####################
:PLUGIN_Url_Name
	if defined %PLUGIN%_Url_Name (%return%)
	
	call :PLUGIN_Url_Basename
	if defined %PLUGIN%_Url_Basename (
		%dk_call% dk_removeExtension	"!%PLUGIN%_Url_Basename!"	%PLUGIN%_Url_Name
	)
	
	:return
	if not defined %PLUGIN%_Url_Name (
		%dk_call% dk_notice "%PLUGIN%_Url_Name:'!%PLUGIN%_Url_Name!' UNDEFEINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Url_Name = '!%PLUGIN%_Url_Name!'"
%endfunction%

rem ####################
:PLUGIN_Url_Name_Lower
	if defined %PLUGIN%_Url_Name_Lower (%return%)
	
	call :PLUGIN_Url_Name
	if defined %PLUGIN%_Url_Name (
		%dk_call% dk_toLower 	"!%PLUGIN%_Url_Name!" 	%PLUGIN%_Url_Name_Lower
	)
	
	:return
	if not defined %PLUGIN%_Url_Name_Lower (
		%dk_call% dk_notice "%PLUGIN%_Url_Name_Lower:'!%PLUGIN%_Url_Name_Lower!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Url_Name_Lower = '!%PLUGIN%_Url_Name_Lower!'"
%endfunction%

rem ##################
:PLUGIN_Install_Path
	if defined %PLUGIN%_Install_Path (%return%)
	
	call :PLUGIN_Install_Dirname
	call :PLUGIN_Install_Name
	
	if defined INSTALL_PATH (
		set "%PLUGIN%_Install_Path=%INSTALL_PATH%"
	) else if defined %PLUGIN%_Install_Dirname (
		if defined %PLUGIN%_Install_Name (
			set "%PLUGIN%_Install_Path=!%PLUGIN%_Install_Dirname!/!%PLUGIN%_Install_Name!"
		)
	)
	
	:return
	if not defined %PLUGIN%_Install_Path (
		%dk_call% dk_notice "%PLUGIN%_Install_Path:'!%PLUGIN%_Install_Path!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Install_Path = '!%PLUGIN%_Install_Path!'"
%endfunction%

rem #################
:PLUGIN_Import_Path
	if defined %PLUGIN%_Import_Path (%return%)
	
	%dk_call% dk_assertVar PLUGIN
	
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_assertVar DKIMPORTS_DIR	
	set "%PLUGIN%_Import_Path=!DKIMPORTS_DIR!/%PLUGIN%"

	:return
	if NOT defined %PLUGIN%_Import_Path (
		%dk_call% dk_notice "%PLUGIN%_Import_Path:'!%PLUGIN%_Import_Path!' UNDEFEINED"
	)
	if NOT EXIST "!%PLUGIN%_Import_Path!" (
		%dk_call% dk_notice "%PLUGIN%_Import_Path:'!%PLUGIN%_Import_Path!' NOT FOUND"
	)
	%dk_call% dk_debug "%PLUGIN%_Import_Path = '!%PLUGIN%_Import_Path!'"
%endfunction%

rem #######################
:PLUGIN_Import_Name_Upper
	if defined %PLUGIN%_Import_Name_Upper (%return%)
	
	call :PLUGIN_Import_Name
	if defined %PLUGIN%_Import_Name (
		%dk_call% dk_toUpper	"!%PLUGIN%_Import_Name!"	%PLUGIN%_Import_Name_Upper
	)
	
	:return
	if not defined %PLUGIN%_Import_Name_Upper (
		%dk_call% dk_notice "%PLUGIN%_Import_Name_Upper:'!%PLUGIN%_Import_Name_Upper!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Import_Name_Upper = '!%PLUGIN%_Import_Name_Upper!'"
%endfunction%

rem ########
:PLUGIN_Id
	if defined %PLUGIN%_Id (%return%)
	
	call :PLUGIN_Import_Name
	if defined %PLUGIN%_Import_Name (
		rem %dk_call% dk_convertToCIdentifier	!%PLUGIN%_Import_Name! 	%PLUGIN%_Id
		set "%PLUGIN%_Id=!%PLUGIN%_Import_Name!"
	)
		
	:return
	if not defined %PLUGIN%_Id (
		%dk_call% dk_notice "%PLUGIN%_Id:'!%PLUGIN%_Id!' UNDEFINED"
	)
	%dk_call% dk_debug "%PLUGIN%_Id = '!%PLUGIN%_Id!'"
%endfunction%

rem ########
:PLUGIN
	if defined PLUGIN (%return%)
	
	if defined IMPORT_NAME (
		set "PLUGIN=%IMPORT_NAME%"
	) else if defined IMPORT_PATH (
		%dk_call% dk_basename "%IMPORT_PATH%" PLUGIN
	) else if defined CURRENT_PLUGIN (
		set "PLUGIN=%CURRENT_PLUGIN%"
	) else if defined DKSCRIPT_DIR (
		%dk_call% dk_basename "%DKSCRIPT_DIR%" PLUGIN
	) else (
		%dk_call% dk_error "Unable to set PLUGIN"
	)

	:return
	if not defined PLUGIN (
		%dk_call% dk_notice "PLUGIN:'%PLUGIN%' UNDEFINED"
	)
	%dk_call% dk_debug "PLUGIN = '%PLUGIN%'"
%endfunction%




rem ########
:PRINTVARS
%setlocal%
	
	%dk_call% dk_debug
	%dk_call% dk_debug "######################## %PLUGIN% variables ########################"
	%dk_call% dk_printPrefixVars "%PLUGIN%"
	%dk_call% dk_debug
%endfunction%





















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_importVariables IMPORT_PATH "%DKIMPORTS_DIR%/git"
	%dk_call% dk_importVariables PRINTVARS
%endfunction%
