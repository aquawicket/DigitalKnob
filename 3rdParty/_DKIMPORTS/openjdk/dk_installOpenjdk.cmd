@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_installOpenjdk()
::#
:dk_installOpenjdk
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	:: https://jdk.java.net/archive/
	if "%HOST_OS%"=="android"                  call dk_set OPENJDK_DL "openjdk-17"
	if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" call dk_set OPENJDK_DL "https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="mac_x86_64"   call dk_set OPENJDK_DL "https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   call dk_set OPENJDK_DL "https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip"
	if not defined OPENJDK_DL call dk_error "OPENJDK_DL is invalid"
	
	call dk_getBasename %OPENJDK_DL% OPENJDK_DL_FILE
	call dk_removeExtension %OPENJDK_DL_FILE% OPENJDK_DL_NAME
	call dk_convertToCIdentifier %OPENJDK_DL_NAME% OPENJDK_FOLDER
	call dk_toLower %OPENJDK_FOLDER% OPENJDK_FOLDER
	
	call dk_validate DK3RDPARTY_DIR "call dk_validateBranch"
	call dk_set OPENJDK %DK3RDPARTY_DIR%\%OPENJDK_FOLDER%
	call dk_set registerJDK11 %OPENJDK%\registerJDK.cmd
	call dk_getNativePath %OPENJDK% OPENJDK_NATIVE
	
	if "%HOST_OS%"=="win"   (call :dk_installOpenJdkWin)
	if "%HOST_OS%"=="mac"   (call :dk_installOpenJdkMac)
	if "%HOST_OS%"=="linux" (call :dk_installOpenJdkLinux)
goto:eof	
	
:dk_installOpenJdkWin
	call dk_set JAVA_VERSION 11
	call dk_set JAVA_VERSION %JAVA_VERSION%
	call dk_set JAVA_HOME %OPENJDK%
	setx JAVA_VERSION %JAVA_VERSION%
	setx JAVA_HOME %OPENJDK%
	setx VS_JavaHome %OPENJDK%
	setx STUDIO_JDK %OPENJDK%
	setx STUDIO_GRADLE_JDK %OPENJDK%
	call dk_registrySetKey "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment" "CurrentVersion" "REG_SZ" "%JAVA_VERSION%"
	call dk_registrySetKey "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\%JAVA_VERSION%" "JavaHome" "REG_SZ" "\"%OPENJDK%\""
	call dk_registrySetKey "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\%JAVA_VERSION%" "RuntimeLib" "REG_SZ" "\"%OPENJDK%\\bin\\server\\jvm.dll\""
	
	:::::: Set Environment Variables ::::::
	call dk_setEnv JAVA_VERSION %JAVA_VERSION%
	call dk_setEnv JAVA_HOME "%OPENJDK_8U41_WINPATH%"
	call dk_setEnv VS_JavaHome "%OPENJDK_8U41_WINPATH%"
	call dk_setEnv STUDIO_JDK "%OPENJDK_8U41_WINPATH%"
	call dk_setEnv STUDIO_GRADLE_JDK "%OPENJDK_8U41_WINPATH%"
goto:eof

:dk_installOpenJdkMac
	if exist "/Library/Java/JavaVirtualMachines/jdk-11.jdk" goto:eof

	call dk_download %OPENJDK_DL%
	call dk_command tar xf %DKDOWNLOAD_DIR%/%OPENJDK_DL_FILE%
	call dk_command sudo mv %DKDOWNLOAD_DIR%/jdk-11.jdk /Library/Java/JavaVirtualMachines/
	call dk_remove %DKDOWNLOAD_DIR%/%OPENJDK_DL_FILE%
	call dk_command java --version 
goto:eof

:dk_installOpenJdkLinux
	::if exist /usr (
	::	call dk_set CURRENT_DIR /usr
	::)
	
	::if "%HOST_OS%"=="android" (
	::	call dk_set SUDO ""
	::	call dk_set APT "apt"
	::) else (
	::	call dk_set SUDO "sudo"
	::	call dk_set APT "apt-get"
	::)
	
	if "%HOST_OS%"=="android" (
		call dk_command pkg install openjdk-17 -y
	) else (
		call dk_command %SUDO% apt update
		call dk_command %SUDO% apt -y install openjdk-11-jdk
	)
	
	call dk_command java --version
goto:eof









::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installOpenjdk
goto:eof