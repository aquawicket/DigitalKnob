@echo off
call DK

::################################################################################
::# dk_arrayToList(<array_name> <output>)
::#
::#
:dk_arrayToList () {

set "array_name=%~1"
echo array_name = %array_name%

call dk_getArrayLength %array_name% array_length
set /a "count=%array_length%-1"
for /l %%n in (0, 1, %count%) do (
	if "%%n"=="0" (
		set "list=!%array_name%[%%n]!"
	) else (
		set "list=!list!;!%array_name%[%%n]!"
	)
)

echo %list%
set "%0=%list%" 
 
%DKEND% 
