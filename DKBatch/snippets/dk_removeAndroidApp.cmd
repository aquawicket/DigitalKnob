:: This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files(the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions :
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

%DKBATCH%
::############################################################################
:dk_removeAndroidApp name error
::#
::# Func:  Uninstall a packgage from an Android device
::#
::# name:  The name of the package to uninstall
::# error:   Returned error code if any
::#
::# Example:  call dk_removeAndroidApp com.company.appname error
::#           echo dk_removeAndroidApp returned: %error%
::###########################################################################
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
