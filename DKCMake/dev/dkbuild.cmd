:: This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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
:: Let's ask the user to type what they want to build
:: It could be an app, library or anything with a DKMAKE.cmake file
:: We whould also give the option to list targets as well

:: get digitalknob paths and install CMake if needed
set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\Development"
set "DKCMAKE=%DIGITALKNOB%\Development\DKCMake"
if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
if NOT exist "%CMAKE%" (
    echo "unable to find CMake.  please install"
	pause
	exit
)

:: get the info needed to start the project file generation
set "OS="
set "CPU="
:pickos
echo.
echo 1. win32
echo 2. win64
echo 3. android32
echo 4. android64
echo 5. Exit
set choice=
set /p choice=Please select an OS to build for: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' set "OS=win32" && set "CPU=Win32" && goto picktarget
if '%choice%'=='2' set "OS=win64" && set "CPU=x64" && goto picktarget
if '%choice%'=='3' set "OS=android32" && set "CPU=ARM" && goto picktarget
if '%choice%'=='4' set "OS=android64" && set "CPU=ARM64" && goto picktarget
if '%choice%'=='5' goto end
ECHO "%choice%" is not valid, please try again
goto pickos

:picktarget
echo Please type the name of the library, tool or app to build. Then press enter.
set /p input=

::Search digitalknob for the matching entry containing a DKMAKE.cmake file  
cd %DIGITALKNOB%
for /f "delims=" %%a in ('dir /b /s /a-d DKMAKE.cmake ^| findstr /E /R "%input%\\DKMAKE.cmake" ') do set "path=%%a"
set "target_path=%path:~0,-13%"
echo target_path = %target_path%

:: Run the cmake configureation on the project
set "cmnd="%CMAKE%" -G "Visual Studio 17 2022" -A %CPU% -DDEBUG=ON -DRELEASE=ON -DSTATIC=ON -DREBUILDALL=ON -DHAVE_DKDuktape=1 -DTARGET=%input% -DOS=%OS% -S "%DKCMAKE%" -B "%target_path%\%OS%" 
echo.
echo %cmnd%
echo.
%cmnd%

::A build.bat file is created for the target/os from Variables.cmake
set "app_batch="%target_path%\%OS%"\build.cmd"
"%app_batch%"


if NOT "%ERRORLEVEL%" == "0" goto error
goto end

:error
echo ERRORLEVEL = %ERRORLEVEL%
pause

:end
ECHO Done 
 
%DKEND% 
