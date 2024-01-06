%dkbatch%

:: https://stackoverflow.com/questions/59504840/create-jni-ndk-apk-only-command-line-without-gradle-ant-or-cmake/59533703#59533703
set "APP_ROOT=%~dp0"
set "APP_PATH=%APP_ROOT%app/src/main"

echo 1. Set and map all variables and environment variables
:: Build architecture and type
set "BUILD_TYPE=Debug"
::set "ABI=armeabi-v7a"
set "ABI=arm64-v8a"

:: Choose a C++ Compilers setting
:: 		options: CMAKE, NDK, CLANG    or GRADLE: must be enabled in build.gradle
set compiler=CMAKE

:: Use gradle to compile Java and Generate apk pagkage?
:: Otherwide the normal android tools will be used 
set GRADLE=1


if [%1] NEQ [] ( set "compiler=%1" )
if "%2"=="GRADLE" ( set GRADLE=1 )

echo #############  BUILD SETTINGS ###############
echo      compiler = %compiler%
echo        GRADLE = %GRADLE%
echo           ABI = %ABI%
echo    BUILD_TYPE = %BUILD_TYPE%
echo #############################################
TITLE %compiler% %GRADLE%


:: App package name and lable
set "TYPE=com"
set "COMPANY=digitalknob"
set "APP_NAME=dk"
set "APP_LABEL=DKApp"

:::::::::::::::::: AAPT :::::::::::::::::::::
:: App signing
set "keypass=123456"
set "FirstLastName=aquawicket"
set "Unit=IT"
set "Orginization=digitalknob"
set "City=Perris"
set "State=CA"
set "Country=US"
::::::::::::::::::::::::::::::::::::::::::::

::::::::::::: CMAKE / CLANG :::::::::::::::::::
:: Android api, ndk and tools versions
set "ANDROID_API=31"
set "NDK=23.1.7779620"
set "BUILD_TOOLS=30.0.3"
:::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo 2. Install 3rd party tools
:: Android SDK
if not exist %ANDROID_HOME% ( %ERROR% "Environment Variable ANDROID_HOME does not exist" )

:: JDK
if %GRADLE% EQU 0 ( 
	set "JAVA_HOME=C:/Users/%USERNAME%/digitalknob/Development/3rdParty/openjdk-8u41-b04-windows-i586-14_jan_2020"
) else (
	set "JAVA_HOME=C:/Users/%USERNAME%/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin"
)
call "%JAVA_HOME%/registerJDK.cmd"
%IF_ERROR% "Failed at call to registerJDK.cmd"

:: CMake
if exist "C:/Program Files/CMake/bin/cmake.exe" set "CMAKE=C:/Program Files/CMake/bin/cmake.exe"
if exist "C:/Program Files (x86)/CMake/bin/cmake.exe" set "CMAKE=C:/Program Files (x86)/CMake/bin/cmake.exe"
set "CMAKE_SOURCE_DIR=%APP_PATH%/cpp"
set "CMAKE_BINARY_DIR=%APP_ROOT%"
%IF_ERROR% "Failed to find CMake, is it installed?"

if "%ABI%"=="armeabi-v7a" (	set "CMAKE_GENERATOR_ARCH=ARM" & goto :end )
if "%ABI%"=="arm64-v8a" ( set "CMAKE_GENERATOR_ARCH=ARM64" & goto :end )
%FATAL% "ABI is invalid"
:end

:: Other mapped variables
set "APK_NAME=%APP_NAME%"
set "PACKAGE_NAME=%TYPE%.%COMPANY%.%APP_NAME%"
set "PACKAGE_DIRS=%TYPE%/%COMPANY%/%APP_NAME%"
set "BUILD_TOOLS_PATH=%ANDROID_HOME%/build-tools/%BUILD_TOOLS%"
set "PLATFORM=%ANDROID_HOME%/platforms/android-%ANDROID_API%"
set "NDK_ROOT=%ANDROID_HOME%/ndk/%NDK%"

:::::::::: CLANG  ( ndk_toolchain ) ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%ABI%"=="armeabi-v7a" (
	set "ANDROID_TOOLCHAIN=%NDK_ROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin\armv7a-linux-androideabi%ANDROID_API%-clang"
) else (
	set "ANDROID_TOOLCHAIN=%NDK_ROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android%ANDROID_API%-clang"
)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




::echo 11. Zipalign the APK package
::It serves to aligns uncompressed files in the APK on 4-byte boundaries for easier memory mapping.
::"%BUILD_TOOLS_PATH%/zipalign" -f -p 4 %APP_PATH%/build/%APK_NAME%.unsigned.apk %APP_PATH%/build/%APK_NAME%.aligned.apk
::%IF_ERROR% "Failed to Zipalign the APK package"


::echo 12. Create a key store and key for signing with the Java keytool
::if not exist "%APP_PATH%/build/keystore.jks" "%JAVA_HOME%/bin/keytool" -genkeypair -keystore %APP_PATH%/build/keystore.jks -alias androidkey -validity 10000 -keyalg RSA -keysize 2048 -storepass %keypass% -dname "CN=%FirstLastName%, OU=%Unit%, O=%Orginization%, L=%City%, S=%State%, C=%Country%" -keypass %keypass%
::%IF_ERROR% "failed to Create a key store and key for signing with the Java keytool"


::echo 13. Sign the APK with apksigner tool
::cmd /c "%BUILD_TOOLS_PATH%/apksigner" sign --ks %APP_PATH%/build/keystore.jks --ks-key-alias androidkey --ks-pass pass:%keypass% --out %APP_PATH%/build/%APK_NAME%.apk %APP_PATH%/build/%APK_NAME%.aligned.apk
::%IF_ERROR% "Failed to Sign the APK with apksigner tool"


::echo 14. Check the APK content with aapt tool
::"%BUILD_TOOLS_PATH%/aapt" list -v %APP_PATH%/build/%APK_NAME%.apk
::%IF_ERROR% "Failed to Check the APK content with aapt tool"
:::end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


echo 15. Uninstall any previous matching package
"%ANDROID_HOME%/platform-tools/adb" shell pm list packages %PACKAGE_NAME%
::echo error level from list packages is %ERRORLEVEL%
"%ANDROID_HOME%/platform-tools/adb" shell pm list packages %PACKAGE_NAME% | findstr /I /C:"%PACKAGE_NAME%"
::echo error level from list packages findstr is %ERRORLEVEL%
if %ERRORLEVEL% EQU 0 ( 
	echo uninstalling previous %PACKAGE_NAME%  package . . .
	"%ANDROID_HOME%/platform-tools/adb" shell pm uninstall %PACKAGE_NAME%
	%IF_ERROR% "Failed to Uninstall previous package"
)




echo 16. Install the apk package to android device
if %GRADLE% EQU 1 (
	"%ANDROID_HOME%/platform-tools/adb" install -r %APP_ROOT%\app\build\outputs\apk\debug\app-debug.apk
) else (
	"%ANDROID_HOME%/platform-tools/adb" install -r %APP_PATH%/build/%APK_NAME%.apk
)
%IF_ERROR% "Failed to Install the apk package to android device"


echo 17. Copying assets to device
call %APP_ROOT%___CopyAssets.cmd %PACKAGE_NAME%


echo 18. Start app
"%ANDROID_HOME%/platform-tools/adb" shell am start --activity-clear-top -n "%PACKAGE_NAME%/.%APP_LABEL%
%IF_ERROR% "Failed to Start app"


call EndProcess adb.exe
call EndProcess java.exe

%DKEND%
