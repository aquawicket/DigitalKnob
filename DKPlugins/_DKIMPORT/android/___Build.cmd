%dkbatch%

:: https://stackoverflow.com/questions/59504840/create-jni-ndk-apk-only-command-line-without-gradle-ant-or-cmake/59533703#59533703
set "APP_ROOT=%~dp0"
set "APP_PATH=%APP_ROOT%app/src/main"
call %APP_ROOT%___Clean

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
set "ANDROID_MIN_API=19"
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
if exist "C:/Program Files/CMake/bin/cmake.exe" set "CMAKE_EXE=C:/Program Files/CMake/bin/cmake.exe"
if exist "C:/Program Files (x86)/CMake/bin/cmake.exe" set "CMAKE_EXE=C:/Program Files (x86)/CMake/bin/cmake.exe"
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



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::: JAVA COMPILING ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if %GRADLE% EQU 1 goto :end
echo 3. Create project build directories
call MakeDirectory %APP_PATH%/build/apk
call MakeDirectory %APP_PATH%/build/gen
%IF_ERROR% "Failed to Create project directories"


echo 4. Generate R.java file with Android Asset Packaging Tool (aapt)
"%BUILD_TOOLS_PATH%/aapt" package -f -m -J %APP_PATH%/build/gen/ -S %APP_PATH%/res -M %APP_PATH%/AndroidManifest.xml -I "%PLATFORM%/android.jar"
:: -f overwrite any existing output file
:: -m create package directories under the output directory
:: -J generate the R.java file and set the output directory
:: -S the resource directory 
:: -M the manifest file
:: -I include the platform/android.jar file
%IF_ERROR% "Failed to Generate R.java file with Android Asset Packaging Tool (aapt)"


echo 5. Compile the java files with javac
::If you see compile errors about JDK version, try use the -source 1.8 -target 1.8 tags in javac command.
javac -source 1.8 -target 1.8 -Xlint -bootclasspath "%JAVA_HOME%/jre/lib/rt.jar" -classpath "%PLATFORM%/android.jar" -d %APP_PATH%/build/obj %APP_PATH%/build/gen/%PACKAGE_DIRS%/R.java %APP_PATH%/java/%PACKAGE_DIRS%/*.java
%IF_ERROR% "Failed to Compile the java files with javac"


echo 6. Translate the .class files in /build/obj/ to Dalvik byte code with dx tool
cmd /c "%BUILD_TOOLS_PATH%/dx" --dex --output=%APP_PATH%/build/apk/classes.dex %APP_PATH%/build/obj
%IF_ERROR% "Failed to Translate the .class files in /build/obj/ to Dalvik byte code with dx tool"


echo 7. Search the C function signature that corresponds to the Java method with javah tool
"%JAVA_HOME%/bin/javah" -classpath "%PLATFORM%/android.jar;%APP_PATH%/build/obj" -o %APP_PATH%/build/tmp/jni.h %PACKAGE_NAME%.%APP_LABEL%
::grep -A1 _getMessage /tmp/jni.h JNIEXPORT jstring JNICALL Java_org_libsdl_app_MainActivity_getMessage(JNIEnv *, jobject);
%IF_ERROR% "Failed to Search the C function signature that corresponds to the Java method with javah tool"
:end

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::: C / C++ JNI COMPILING ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo 8. Create build output directories
::call MakeDirectory %APP_PATH%/build/apk/lib
::call MakeDirectory %APP_PATH%/build/apk/lib/%ABI%
::call MakeDirectory %APP_PATH%/jniLibs
::call MakeDirectory %APP_PATH%/jniLibs/%ABI%

if "%compiler%"=="GRADLE" goto :gradle



:::::: COMPILE WITH CMAKE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if %compiler% NEQ CMAKE goto :end
echo Compiling with CMAKE
::Prep Visual Studio Project
::call CopyPath %APP_PATH%/visualStudio/%ABI%/Directory.Build.targets %CMAKE_BINARY_DIR%/Directory.Build.targets
::call CopyPath %APP_PATH%/visualStudio/%ABI%/gradleAPK.androidproj %CMAKE_BINARY_DIR%/gradleAPK.androidproj

::Generate CMake project files
"%CMAKE_EXE%" -G "Visual Studio 17 2022" -A %CMAKE_GENERATOR_ARCH% -DANDROID_ABI=%ABI% -DANDROID_PLATFORM=%ANDROID_API% -DANDROID_NDK=%NDK_ROOT% -DCMAKE_TOOLCHAIN_FILE=%NDK_ROOT%/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static %CMAKE_SOURCE_DIR% -B%CMAKE_BINARY_DIR%
%IF_ERROR% "CMAKE failed to generate the project files."
"%CMAKE_EXE%" --build %CMAKE_BINARY_DIR% --target main
::call CopyPath %CMAKE_BINARY_DIR%/%BUILD_TYPE%/libmain.so %APP_PATH%/build/apk/lib/%ABI%/libmain.so
:end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::: COMPILE WITH NDK-BUILD :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if %compiler% NEQ NDK goto :end
echo Compiling with ndk-build
call %NDK_ROOT%/ndk-build NDK_LOG=1 APP_BUILD_SCRIPT=%APP_PATH%/cpp/Android.mk NDK_PROJECT_PATH=%APP_PATH%
call CopyPath %APP_PATH%\libs\%ABI%\libmain.so %APP_PATH%/build/apk/lib/%ABI%/libmain.so
call CopyPath %APP_PATH%\libs\%ABI%\libmain.so %APP_PATH%/jniLibs/%ABI%/libmain.so
:end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::: COMPILE WITH CLANG  ( ndk_toolchain ) :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if %compiler% NEQ CLANG goto :end
echo Compiling with NDK Toolchain
call MakeDirectory %APP_PATH%/build/apk/lib/%ABI%
cmd /c %ANDROID_TOOLCHAIN% -shared -o %APP_PATH%/build/apk/lib/%ABI%/libmain.so %APP_PATH%/cpp/main.c
call CopyPath %APP_PATH%/build/apk/lib/%ABI%/libmain.so %APP_PATH%/jniLibs/%ABI%/libmain.so
:end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::: COMPILE WITH GRADLE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gradle
::if "%compiler%"=="GRADLE" (
	::set GRADLE_SETTINGS=--project-prop=BUILD_LIBS
::)
if %GRADLE% NEQ 1 goto :end
echo Compiling with Gradle
set "GRADLE_USER_HOME=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\gradle"
setx GRADLE_USER_HOME %GRADLE_USER_HOME%

echo 2. Run gradle clean build
cmd /c %APP_ROOT%gradlew --project-dir %APP_ROOT% %GRADLE_SETTING% --info clean build 
%IF_ERROR% "Gradle Build Failed"
:end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%IF_ERROR% "failed to compile libmain.so"



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if %GRADLE% EQU 1 goto :end
echo 10. Package the APK
call MakeDirectory %APP_PATH%/assets/
"%BUILD_TOOLS_PATH%/aapt" package -f -M %APP_PATH%/AndroidManifest.xml -S %APP_PATH%/res/ -A %APP_PATH%/assets/ -I "%PLATFORM%/android.jar" -F %APP_PATH%/build/%APK_NAME%.unsigned.apk %APP_PATH%/build/apk/
%IF_ERROR% "Failed to Package the APK"


echo 11. Zipalign the APK package
::It serves to aligns uncompressed files in the APK on 4-byte boundaries for easier memory mapping.
"%BUILD_TOOLS_PATH%/zipalign" -f -p 4 %APP_PATH%/build/%APK_NAME%.unsigned.apk %APP_PATH%/build/%APK_NAME%.aligned.apk
%IF_ERROR% "Failed to Zipalign the APK package"


::echo 12. Create a key store and key for signing with the Java keytool
if not exist "%APP_PATH%/build/keystore.jks" "%JAVA_HOME%/bin/keytool" -genkeypair -keystore %APP_PATH%/build/keystore.jks -alias androidkey -validity 10000 -keyalg RSA -keysize 2048 -storepass %keypass% -dname "CN=%FirstLastName%, OU=%Unit%, O=%Orginization%, L=%City%, S=%State%, C=%Country%" -keypass %keypass%
%IF_ERROR% "failed to Create a key store and key for signing with the Java keytool"


echo 13. Sign the APK with apksigner tool
cmd /c "%BUILD_TOOLS_PATH%/apksigner" sign --ks %APP_PATH%/build/keystore.jks --ks-key-alias androidkey --ks-pass pass:%keypass% --out %APP_PATH%/build/%APK_NAME%.apk %APP_PATH%/build/%APK_NAME%.aligned.apk
%IF_ERROR% "Failed to Sign the APK with apksigner tool"


echo 14. Check the APK content with aapt tool
"%BUILD_TOOLS_PATH%/aapt" list -v %APP_PATH%/build/%APK_NAME%.apk
%IF_ERROR% "Failed to Check the APK content with aapt tool"
:end
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
