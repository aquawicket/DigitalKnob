%dkbatch%

set "array_name=%~1"
if "%array_name%"=="" (
	echo [91m array_name is invalid, providing test variables [0m
	set "test[0]=test0"
	set "test[1]=test1"
	set "test[2]=test2"
	set "test[3]=test3"
	set "test[4]=test4"
	set "array_name=test"
)
echo array_name = %array_name%

call GetArrayLength %array_name%
set /a "count=%GetArrayLength%-1"
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
