@echo off
rem https://gist.github.com/api0cradle/cdd2d0d0ec9abb686f0e89306e277b8f




:main
	rem ### The ads stream path (inside this file)
	set "ads_file=%~f0"

	rem ### write text to ads
	call :write_text_to_ads "%ads_file%:TextA" "This is a hidden line of text" 

	rem ### print ads Content
	call :print_ads "%ads_file%:TextA"

	rem ### append text to ads
	call :append_text_to_ads "%ads_file%:TextA" "String appended to TextA ads" 

	rem ### print ads Content
	call :print_ads "%ads_file%:TextA"
	
	rem ### write file to ads
	call :write_file_to_ads "%ads_file%:test.gif" "%~dp0test.gif"
	
	cmd < "%ads_file%:test.gif"
	
	
	
rem	call :ads_exists "%cat_ads_exe%" && (
rem		echo ads exists
rem	) || (
rem		echo ads NOT FOUND
rem	)
	
rem	### $DATA = this stream
rem	set "cat_ads_exe=%~f0:$DATA" && (
rem		echo ads exists
rem	) || (
rem		echo ads NOT FOUND
rem	)
	pause
exit /b %errorlevel%



rem ####################################
:ads_exists  ads path
	(sort.exe < "%~1") 1>nul 2>nul && exit /b 0 || exit /b 1
exit /b %errorlevel%


rem #####################################
:write_text_to_ads asd_path "string"
	echo.%~2> "%~1"
exit /b %errorlevel%


rem #####################################
:append_text_to_ads asd_path "string"
	>>"%~1" (echo.%~2)
exit /b %errorlevel%


rem #####################################
:write_file_to_ads asd_path "file_path"
	type %~2 > "%~1:%~nx2"
exit /b %errorlevel%


rem #####################################
:read_ads_to_file ads_path "file_path"
	expand.exe "%~1" "%~1"
	rem powershell -C $a = Get-Content %~1 -Encoding Byte -ReadCount 0;Set-Content %~2 -Encoding Byte -Value $a
exit /b %errorlevel%


rem #####################################
:execute_ads ads_path
	wmic process call create '"%~1"'
exit /b %errorlevel%


rem #####################################
:print_ads ads_path
	for /f "usebackq delims=φ" %%i in (%~1) do echo %%i
exit /b %errorlevel%
