%DKBATCH%

SETLOCAL 
call :function1
call :function7
call :function4
call :function2 
exit /b %ERRORLEVEL% 

:function1
echo function1
exit /b %ERRORLEVEL% 

:function2
echo function2
exit /b %ERRORLEVEL% 

:function3
echo function3
exit /b %ERRORLEVEL% 

:function4
echo function4
exit /b %ERRORLEVEL% 

:function5
echo function5
exit /b %ERRORLEVEL% 

:function6
echo function6
exit /b %ERRORLEVEL% 

:function7
echo function7
exit /b %ERRORLEVEL% 

%DKEND%