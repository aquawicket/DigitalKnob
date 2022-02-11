%DKBATCH%
:: https://stackoverflow.com/questions/59504840/create-jni-ndk-apk-only-command-line-without-gradle-ant-or-cmake/59533703#59533703


tasklist /fi "imagename eq adb.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "adb.exe
tasklist /fi "imagename eq java.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "java.exe
if NOT "%ERRORLEVEL%" == "0" goto error


::Tutorial build java and JNI/NDK APK
echo 1. Install JDK8, android SDK, android NDK, build-tools, platform-tools and the android platform.
if NOT "%ERRORLEVEL%" == "0" goto error


echo 2. Set the environment variables.
set "APP_NAME=app"
set "COMPANY=libsdl"
set "TYPE=org"
set "API=26"
set "NDK=22.1.7171670"
set "ABI=arm64-v8a"
set "BUILD_TOOLS=30.0.3"
set "SDK=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\android-sdk"
set "JAVA_HOME=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openjdk-11"
set "CMAKE_C_FLAGS=-DANDROID -DANDROID32 -std=c17 -fno-rtti -fno-exceptions"
set "CMAKE_C_FLAGS_DEBUG=-DDEBUG -D_DEBUG -g"
set "CMAKE_C_FLAGS_RELEASE=-DNDEBUG -DRELEASE -O3"
set "CMAKE_CXX_FLAGS=-DANDROID -DANDROID32 -std=c++1z -fno-rtti -fno-exceptions"
set "CMAKE_CXX_FLAGS_DEBUG=-DDEBUG -D_DEBUG -g"
set "CMAKE_CXX_FLAGS_RELEASE=-DNDEBUG -DRELEASE -O3"
if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
set "PLATFORM=%SDK%\platforms\android-%API%"
set "NDK_ROOT=%SDK%\ndk\%NDK%"
call "%JAVA_HOME%\registerJDK.cmd"
if NOT "%ERRORLEVEL%" == "0" goto error



echo 3. Create project directories
cd %~dp0
cd ..
cd ..
cd ..
cd ..
set APP_ROOT=%CD%
echo APP_ROOT = %APP_ROOT%
if not exist "%APP_ROOT%\app\build" mkdir "%APP_ROOT%\app\build"
if not exist "%APP_ROOT%\app\build\cmake" mkdir %APP_ROOT%\app\build\cmake
if not exist "%APP_ROOT%\app\build\cmake\%ABI%" mkdir %APP_ROOT%\app\build\cmake\%ABI%
if NOT "%ERRORLEVEL%" == "0" goto error





echo 4. Create the libmain.so with arm toolchain
::copy %APP_ROOT%\visualStudio\%ABI%\Directory.Build.targets  %APP_ROOT%\app\build\cmake\%ABI%\Directory.Build.targets

::set "CODED_DIR=w1v692t5\"
set "BUILD_TYPE=Release"
set "NDK=C:\Users\Administrator\digitalknob\DK\3rdParty\android-sdk\ndk\22.1.7171670"
set "BINARY_DIR=%APP_ROOT%\app\.cxx\%BUILD_TYPE%\%CODED_DIR%%ABI%"

:: GRADLE'S CMAKE COMMAND

::set "ANDROID_ABI=-DANDROID_ABI=%ABI%"
::set "CMAKE_GENERATOR=-GNinja"
::set "CMAKE_SOURCE_DIR=-S%APP_ROOT%\app\src\main\cpp"
::set "CMAKE_BINARY_DIR=-B%APP_ROOT%\app\.cxx\%BUILD_TYPE%\%CODED_DIR%%ABI%"
::set "CMAKE_LIBRARY_OUTPUT_DIRECTORY=-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%APP_ROOT%\app\build\intermediates\cxx\%BUILD_TYPE%\%CODED_DIR%obj\%ABI%"
::set "CMAKE_RUNTIME_OUTPUT_DIRECTORY=-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=%APP_ROOT%\app\build\intermediates\cxx\%BUILD_TYPE%\%CODED_DIR%obj\%ABI%"
::set "CMAKE_MAKE_PROGRAM=-DCMAKE_MAKE_PROGRAM=C:\Users\Administrator\digitalknob\DK\3rdParty\android-sdk\cmake\3.10.2.4988404\bin\ninja.exe"


:: DIGITALKNOB'S CMAKE COMMAND
set "CMAKE_SYSTEM_NAME=-DCMAKE_SYSTEM_NAME=Android"
set "CMAKE_EXPORT_COMPILE_COMMANDS=-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
set "CMAKE_SYSTEM_VERSION=-DCMAKE_SYSTEM_VERSION=%API%"
set "ANDROID_PLATFORM=-DANDROID_PLATFORM=android-%API%"
set "CMAKE_ANDROID_ARCH_ABI=-DCMAKE_ANDROID_ARCH_ABI=%ABI%"
set "ANDROID_NDK=-DANDROID_NDK=%NDK%"
set "CMAKE_ANDROID_NDK=-DCMAKE_ANDROID_NDK=%NDK%"
set "CMAKE_TOOLCHAIN_FILE=-DCMAKE_TOOLCHAIN_FILE=%NDK%\build\cmake\android.toolchain.cmake"
set "CMAKE_BUILD_TYPE=-DCMAKE_BUILD_TYPE=%BUILD_TYPE%"
set "ANDROID_APP_PLATFORM=-DANDROID_APP_PLATFORM=android-%API%"
set "ANDROID_STL=-DANDROID_STL=c++_static"
set "ANDROID_ABI=-DANDROID_ABI=%ABI%"
set "CMAKE_GENERATOR=-G "Visual Studio 17 2022" -A ARM64"
set "CMAKE_SOURCE_DIR=-S%APP_ROOT%\app\src\main\cpp"
set "CMAKE_BINARY_DIR=-B%BINARY_DIR%"
set "CMAKE_LIBRARY_OUTPUT_DIRECTORY=-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%APP_ROOT%\app\build\intermediates\cxx\%BUILD_TYPE%\%CODED_DIR%obj\%ABI%"
set "CMAKE_RUNTIME_OUTPUT_DIRECTORY=-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=%APP_ROOT%\app\build\intermediates\cxx\%BUILD_TYPE%\%CODED_DIR%obj\%ABI%"
::set "CMAKE_MAKE_PROGRAM="

::"%CMAKE%" -G "Visual Studio 17 2022" -A ARM -DANDROID_ABI=%ABI% -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DANDROID_PLATFORM=%API% -DANDROID_NDK=%NDK_ROOT% -DCMAKE_TOOLCHAIN_FILE=%NDK_ROOT%/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static "-DCMAKE_C_FLAGS=%CMAKE_C_FLAGS%" "-DCMAKE_C_FLAGS_DEBUG=%CMAKE_C_FLAGS_DEBUG%" "-DCMAKE_C_FLAGS_RELEASE=%CMAKE_C_FLAGS_RELEASE%" "-DCMAKE_CXX_FLAGS=%CMAKE_CXX_FLAGS%" "-DCMAKE_CXX_FLAGS_DEBUG=%CMAKE_CXX_FLAGS_DEBUG%" "-DCMAKE_CXX_FLAGS_RELEASE=%CMAKE_CXX_FLAGS_RELEASE%" %APP_ROOT%/app/src/main/cpp -B%APP_ROOT%/app/build/cmake/%ABI%
copy %APP_ROOT%\visualStudio\%ABI%\Directory.Build.targets  %BINARY_DIR%\Directory.Build.targets
copy %APP_ROOT%\visualStudio\%ABI%\gradleAPK.androidproj %BINARY_DIR%\gradleAPK.androidproj
"%CMAKE%" %CMAKE_SYSTEM_NAME% %CMAKE_EXPORT_COMPILE_COMMANDS% %CMAKE_SYSTEM_VERSION% %ANDROID_PLATFORM% %CMAKE_ANDROID_ARCH_ABI% %ANDROID_NDK% %CMAKE_ANDROID_NDK% %CMAKE_TOOLCHAIN_FILE% %CMAKE_MAKE_PROGRAM% %CMAKE_LIBRARY_OUTPUT_DIRECTORY% %CMAKE_RUNTIME_OUTPUT_DIRECTORY% %CMAKE_BUILD_TYPE% %CMAKE_BINARY_DIR% %CMAKE_GENERATOR% %ANDROID_APP_PLATFORM% %ANDROID_STL% %ANDROID_ABI% "-DCMAKE_C_FLAGS=%CMAKE_C_FLAGS%" "-DCMAKE_C_FLAGS_DEBUG=%CMAKE_C_FLAGS_DEBUG%" "-DCMAKE_C_FLAGS_RELEASE=%CMAKE_C_FLAGS_RELEASE%" "-DCMAKE_CXX_FLAGS=%CMAKE_CXX_FLAGS%" "-DCMAKE_CXX_FLAGS_DEBUG=%CMAKE_CXX_FLAGS_DEBUG%" "-DCMAKE_CXX_FLAGS_RELEASE=%CMAKE_CXX_FLAGS_RELEASE%" %CMAKE_SOURCE_DIR%
:: using ninjs, the command line becomes 
::C:\\Users\\Administrator\\digitalknob\\DK\\3rdParty\\android-sdk\\ndk\\22.1.7171670\\toolchains\\llvm\\prebuilt\\windows-x86_64\\bin\\clang++.exe --target=armv7-none-linux-androideabi%API% --gcc-toolchain=C:/Users/Administrator/digitalknob/DK/3rdParty/android-sdk/ndk/22.1.7171670/toolchains/llvm/prebuilt/windows-x86_64 --sysroot=C:/Users/Administrator/digitalknob/DK/3rdParty/android-sdk/ndk/22.1.7171670/toolchains/llvm/prebuilt/windows-x86_64/sysroot -DANDROID -DANDROID32 -Dmain_EXPORTS -IC:/Users/Administrator/digitalknob/DK/3rdParty/SDL2-main/include -IC:/Users/Administrator/digitalknob/DK/3rdParty/SDL2_ttf-main -g -DANDROID -fdata-sections -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -D_FORTIFY_SOURCE=2 -march=armv7-a -mthumb -Wformat -Werror=format-security -O0 -fno-limit-debug-info -fPIC -o C:\\main.cpp.o -c C:\\Users\\Administrator\\digitalknob\\sdl2vs\\AndroidProject1\\app\\src\\main\\cpp\\main.cpp

"%CMAKE%" --build %BINARY_DIR%
if NOT "%ERRORLEVEL%" == "0" goto error

echo close abd.exe and java.exe
tasklist /fi "imagename eq adb.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "adb.exe
tasklist /fi "imagename eq java.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "java.exe
if NOT "%ERRORLEVEL%" == "0" goto error

goto end

:error
echo Failed with error code: %ERRORLEVEL%
pause

:end
ECHO Done