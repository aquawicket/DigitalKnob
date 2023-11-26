:: Windows Batch file DK builder
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
set "DKCMAKE=%DIGITALKNOB%\DK\DKCMake"
set "DKDOWNLOAD=%DIGITALKNOB%\download"
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
::set "MSBUILD_DL=https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe"
set "MSBUILD_DL=https://aka.ms/vs/17/release/vs_community.exe"
set "download=certutil.exe -urlcache -split -f"
::set "download=bitsadmin /transfer myDownloadJob /download /priority normal"
set "APP="
set "OS="
set "TYPE="
if NOT exist "%DIGITALKNOB%" mkdir "%DIGITALKNOB%"
if NOT exist "%DKDOWNLOAD%" mkdir "%DKDOWNLOAD%"

cd "%DIGITALKNOB%"
rmdir /s "%DKPATH%"
rmdir /s "%DKDOWNLOAD%"

:checkGit
if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
if NOT exist "%GIT%" (
	ECHO "installing git"
	%download% %GIT_DL% "%DKDOWNLOAD%\Git-2.30.1-32-bit.exe"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	"%DKDOWNLOAD%\Git-2.30.1-32-bit.exe" /VERYSILENT /NORESTART
	::if NOT "%ERRORLEVEL%" == "0" goto error
	if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
	if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
)

:gitupdate
if NOT exist "%DKPATH%\.git" (
	"%GIT%" clone https://github.com/aquawicket/DigitalKnob.git "%DKPATH%"
)
if NOT "%ERRORLEVEL%" == "0" goto error
cd "%DKPATH%"
"%GIT%" pull --all
"%GIT%" checkout -- .
if NOT "%ERRORLEVEL%" == "0" goto error
"%GIT%" checkout Development
if NOT "%ERRORLEVEL%" == "0" (
	echo Remote has no Development branch. Creating...
	"%GIT%" checkout -b Development main
	"%GIT%" push --set-upstream origin Development
)


:pickapp
set APP=DKBuilder


:pickos
set OS="win32"


:type
set TYPE="All"


:deleteCache
echo Deleteing CMake cache . . .
cd "%DIGITALKNOB%"
for /r %%i in (CMakeCache.*) do del "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error
for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error

echo Deleteing .tmp files . . .
cd "%DIGITALKNOB%"
for /r %%i in (*.tmp) do del "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error
for /r %%i in (*.TMP) do del "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error


:checkCmake
if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
if NOT exist "%CMAKE%" (
    echo "installing cmake"
	echo "%CMAKE_DL%"
	%download% %CMAKE_DL% "%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
	if NOT "%ERRORLEVEL%" == "0" goto error
	"%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
	if NOT "%ERRORLEVEL%" == "0" goto error
	if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
	if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
)


:checkVisualStudio
if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if NOT exist "%MSBUILD%" (
    echo "installing Visual Studio"
	echo "%MSBUILD_DL%"
	
	%download% %MSBUILD_DL% "%DKDOWNLOAD%\vs_Community.exe"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	"%DKDOWNLOAD%\vs_Community.exe"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
)

:build
echo ****** BUILDING %APP% - %OS% ******
set "APP_PATH=%DKPATH%\DKApps\%APP%"
ECHO %APP_PATH%
if NOT exist "%APP_PATH%\%OS%" mkdir "%APP_PATH%\%OS%"
::if NOT "%ERRORLEVEL%" == "0" goto error
cd "%APP_PATH%\%OS%"
::"%CMAKE%" -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKCMAKE%
"%CMAKE%" -G "Visual Studio 17 2022" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKCMAKE%
::if NOT "%ERRORLEVEL%" == "0" goto error
"%MSBUILD%" %APP%.sln /p:Configuration=Debug
::if NOT "%ERRORLEVEL%" == "0" goto error
"%MSBUILD%" %APP%.sln /p:Configuration=Release
::if NOT "%ERRORLEVEL%" == "0" goto error

goto end

:error
echo Failed with error code: %ERRORLEVEL%
pause

:end
ECHO Done
::exit