%dkbatch%

:: Stop running processes and map APP_ROOT
call EndProcess adb.exe
call EndProcess java.exe
set APP_ROOT=%~dp0

cd %APP_ROOT%

:: Left by Gradle
for /d /r %%i in (*.gradle) do rd /s /q "%%i"
for /d /r %%i in (*build) do rd /s /q "%%i"
for /d /r %%i in (*.cxx) do rd /s /q "%%i"
for /d /r %%i in (*jniLibs) do rd /s /q "%%i"
for /d /r %%i in (*libs) do rd /s /q "%%i"
for /d /r %%i in (*obj) do rd /s /q "%%i"


:: left by Visual Studio
for /d /r %%i in (*.vs) do rd /s /q "%%i"
for /d /r %%i in (*.dir) do rd /s /q "%%i"
for /d /r %%i in (*ARM) do rd /s /q "%%i"
for /d /r %%i in (*ARM64) do rd /s /q "%%i"
for /d /r %%i in (*CMakeFiles) do rd /s /q "%%i"
for /d /r %%i in (*Debug) do rd /s /q "%%i"
for /d /r %%i in (*Release) do rd /s /q "%%i"
for /d /r %%i in (*MinSizeRel) do rd /s /q "%%i"
for /d /r %%i in (*RelWithDebInfo) do rd /s /q "%%i"
for /r %%i in (CMakeCache.*) do del "%%i"
for /r %%i in (cmake_install.*) do del "%%i"
for /r %%i in (*.vcxproj) do del "%%i"
for /r %%i in (*.sln) do del "%%i"
for /r %%i in (*.filters) do del "%%i"
for /r %%i in (*.user) do del "%%i"

%DKEND%
