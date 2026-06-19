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


rem ##########################################
:DKINSTALL

	rem ###### ftype ######
	ftype DKShebang=
	ftype DKShebang="%ComSpec:/=\%" /V:ON /k call "%~dp0DKShebang.cmd" "%%1" %%*
  
  
	::######################## .asm ########################
	::#
	::#
	rem ###### assoc ######
	assoc .asm=
	assoc .asm=DKShebang
  
  
	::######################## .bash ########################
	::#
	::# 
	assoc .bash=
	assoc .bash=DKShebang
  
  
	::######################## .bat ########################
	::#
	::# 
	assoc .bat=
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat"
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.bat
	rem # HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat\OpenWithList
	assoc .bat=DKShebang
  
  
	::######################## .c ########################
	::#
	::# 
	assoc .c=
	assoc .c=DKShebang
  
  
	::######################## .cmake ########################
	::#
	::# 
	assoc .cmake=
	assoc .cmake=DKShebang


	::######################## .cmd ########################
	::#
	::# 
rem  assoc .cmd=
rem  assoc .cmd=DKShebang


	::######################## .cpp ########################
	::#
	::# 
	assoc .cpp=
	assoc .cpp=DKShebang


	::######################## .cs ########################
	::#
	::# 
	assoc .cs=
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cs"
	rem # HKEY_CLASSES_ROOT\.cs
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.cs
	rem # HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cs
	rem # HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cs
	assoc .cs=DKShebang


	::######################## .hta ########################
	::#
	::# 
	assoc .hta=
	assoc .hta=DKShebang
  
  
	::######################## .htm ########################
	::#
	::# 
	assoc .htm=
	rem # HKEY_CLASSES_ROOT\.htm
	rem # HKEY_CLASSES_ROOT\SystemFileAssociations\.htm
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm"
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.htm
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.htm
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Portable Devices\FormatMap\.htm
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows Portable Devices\FormatMap\.htm
	rem # HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm
	rem # HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm
	assoc .htm=DKShebang


	::######################## .html ########################
	::#
	::# 
	assoc .html=
	rem # HKEY_CLASSES_ROOT\.html
	rem # HKEY_CLASSES_ROOT\SystemFileAssociations\.html
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html"
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.html
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.html
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Portable Devices\FormatMap\.html
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows Portable Devices\FormatMap\.html
	rem # HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html
	rem # HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html
	assoc .html=DKShebang
	
	
	::######################## .java ########################
	::#
	::# 
	assoc .java=
	assoc .java=DKShebang


	::######################## .js ########################
	::# depends on cscript.exe
	::# 
	assoc .js=
	rem # HKEY_CLASSES_ROOT\.js
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.js
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Portable Devices\FormatMap\.js
	rem # HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows Portable Devices\FormatMap\.js
	rem # HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js
	rem # HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js
	assoc .js=DKShebang
	
	
	::######################## .mhtml ########################
	::#
	::# 
	assoc .mhtml=
	assoc .mhtml=DKShebang

	
	::######################## .php ########################
	::#
	::# 
	assoc .php=
	assoc .php=DKShebang


	::######################## .pl ########################
	::#
	::# 
	assoc .pl=
	assoc .pl=DKShebang
  
  
	::######################## .ps1 ########################
	::#
	::# 
	assoc .ps1=
	assoc .ps1=DKShebang


	::######################## .py ########################
	::#
	::# 
	assoc .py=
	assoc .py=DKShebang
  
  
	::######################## .rb ########################
	::#
	::# 
	assoc .rb=
	assoc .rb=DKShebang


	::######################## .sh ########################
	::#
	::# 
	assoc .sh=
	assoc .sh=DKShebang


	::######################## .vba ########################
	::#
	::# %dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs"
	assoc .vbs=
	assoc .vbs=DKShebang


	::########### ICON #############
	%dk_call% dk_registrySetKey "HKCR/DKShebang/DefaultIcon" "" "REG_SZ" "%~dp0icon.ico"
	
	
	%dk_call% dk_success "DKShebang install complete"
%endfunction%
