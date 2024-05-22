@echo off
call DK

::#################################################################################
:: dk_setFileAssoc() <extension> <exe> <arguments>
::
::
:dk_setFileAssoc
	call dk_debugFunc
	if %__ARGC__% lss 2 (call dk_error "%__FUNCTION__%(): not enough arguments")

	:: <_extension_>
	set "_extension_=%~1"

	:: <exe>
	call dk_getName "%~2" _exeName_
	call dk_getFilename "%~2" _exeFilename_

	:: <arguments>
	set "_arguments_=%~3"
	
	set "_dkname_=dk%_exeName_%"

	:: set file association using ftype ad assoc
	echo ftype %_dkname_%=%~2 "%%1"
	call ftype %_dkname_%=%~2 "%%1"
	
	echo assoc %_extension_%=%_dkname_%
	call assoc %_extension_%=%_dkname_%
	
	:: set file association through registry
	
	::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:a=program.exe
	call dk_setRegistryKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "a" "REG_SZ" "%~2"
	
	::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:MRUList=program.a
	call dk_setRegistryKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "MRUList" "REG_SZ" "a"
	
	::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\UserChoice REG_SZ:ProgId=Applications\program.exe
	call dk_setRegistryKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\UserChoice" "ProgId" "REG_SZ" "Applications\%_exeFilename_%"

goto:eof





:DKTEST ########################################################################

	call dk_setFileAssoc ".txt" "C:\Windows\System32\notepad.exe"
	