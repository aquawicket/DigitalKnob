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
	set "_exe_=%~2"
	call dk_getName "%~2" _exeName_
	call dk_getFilename "%~2" _exeFilename_

	:: <arguments>
	set "_arguments_=%~3"
	
	set "_dkname_=dk%_exeName_%"

	:: set file association using ftype ad assoc
	call ftype %_dkname_%=%~2 "%%1"
	
	call assoc %_extension_%=%_dkname_%
	
	:: set file association through registry
	
	::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:a=program.exe
	::call dk_registrySetKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "a" "REG_SZ" "%~2"
	
	::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:MRUList=program.a
	::call dk_registrySetKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "MRUList" "REG_SZ" "a"
	
	::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\UserChoice REG_SZ:ProgId=Applications\program.exe
	::call dk_registrySetKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\UserChoice" "ProgId" "REG_SZ" "Applications\%_exeFilename_%"


	::[HKEY_CLASSES_ROOT\.txt]
	::@="emeditor.txt"
	call dk_registrySetKey "HKEY_CLASSES_ROOT\%_extension_%" "" "REG_SZ" "%_dkname_%"

	::[HKEY_CLASSES_ROOT\emeditor.txt]
	::@="Text Document"
	set "_description_=Text Document"
	call dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%" "" "REG_SZ" "%_description_%"

	::[HKEY_CLASSES_ROOT\emeditor.txt\DefaultIcon]
	::@="%SystemRoot%\\SysWow64\\imageres.dll,-102"
	call dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%\DefaultIcon" "" "REG_SZ" "%SystemRoot%\\SysWow64\\imageres.dll,-102"

	::[HKEY_CLASSES_ROOT\emeditor.txt\shell]

	::[HKEY_CLASSES_ROOT\emeditor.txt\shell\open]

	::[HKEY_CLASSES_ROOT\emeditor.txt\shell\open\command]
	::@="\"C:\\Program Files\\EmEditor\\EMEDITOR.EXE\" \"%1\""
	call dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%\shell\open\command" "" "REG_EXPAND_SZ" "\"%_exe_%\" \"%%%%^1\""
	
	::[HKEY_CLASSES_ROOT\emeditor.txt\shell\print]

	::[HKEY_CLASSES_ROOT\emeditor.txt\shell\print\command]
	::@="\"C:\\Program Files\\EmEditor\\EMEDITOR.EXE\" /p \"%1\""
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%\shell\print\command" "@" "REG_SZ" "\"%_exe_%\" /p \"%1\""

goto:eof





:DKTEST ########################################################################

	call dk_setFileAssoc ".txt" "C:\Windows\System32\notepad.exe"





	