%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:UninstallPackage name error
::
:: Func:  Uninstall a packgage from an Android device
::
:: name:  The name of the package to uninstall
:: error:   Returned error code if any
::
:: Example:  call UninstallPackage com.company.appname error
::           echo UninstallPackage returned: %error%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "name=%~1"

if not defined %name% (
	echo ERROR: The "name" argument is invalid
	goto :end
)

if not defined %ANDROID_HOME% (
	echo ERROR: The ANDROID_HOME environment variable is undefined
	goto :end
)

if not exist "%ANDROID_HOME%/platform-tools/adb" (
	echo ERROR: Could not locate adb
	goto :end
) 

"%ANDROID_HOME%/platform-tools/adb" shell pm uninstall %name%

:end 
endlocal & set "%2=%ERRORLEVEL%"
%DKEND%