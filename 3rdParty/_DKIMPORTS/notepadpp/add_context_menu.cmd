@echo off
set "DIGITALKNOB_DIR=C:\\Users\\aquawicket\\digitalknob"

echo Adding 'Edit with Notepad++' context menu to Windows 
set "NOTEPADPP=%DIGITALKNOB_DIR%\\DKTools\\npp.8.6.5.portable\\notepad++.exe"
REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /v Icon /t REG_SZ /d "\"%NOTEPADPP%\"" /f
REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" /ve /d "\"%NOTEPADPP%\" \"%%1\"" /f

echo complete
pause