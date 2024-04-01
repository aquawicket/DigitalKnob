@echo off
set "DIGITALKNOB_DIR=C:\\Users\\aquawicket\\digitalknob"

echo Adding 'GIT ADD' context menu to Windows 
set "GIT_EXE=%DIGITALKNOB_DIR%\\DKTools\\portablegit_2_44_0_64_bit_7z\\cmd\\git.exe"
REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\GITADD" /ve /d "&GIT ADD" /f
REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\GITADD" /v Icon /t REG_SZ /d "imageres.dll,-5324" /f
REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\GITADD\command" /ve /d "\"%GIT_EXE%\" add \"%%1\"" /f

echo complete
pause