@echo off

::Change the security to protect writing to al file in a folder

set "Folder=%USERPROFILE:\=/%/Desktop/Test"
set "Security=%userdomain%/%username%"

if NOT DEFINED icacls.exe (
	set "icacls.exe=C:/Windows/System32/icacls.exe"
)
"%icacls.exe:/=\%" "%Folder:/=\%\*" /deny "%Security:/=\%":(OI)(WA)

pause