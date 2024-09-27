@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installOpenjdk()
::#
:dk_installOpenjdk
	call dk_debugFunc 0
	
	
	%dk_call% dk_validate HOST_TRIPLE "%dk_call% dk_HOST_TRIPLE"
	:: https://jdk.java.net/archive/
	if "%HOST_OS%"=="ANDROID"                  %dk_call% dk_set OPENJDK_DL "openjdk-17"
	if "%HOST_OS%_%HOST_ARCH%"=="LINUX_X86_64" %dk_call% dk_set OPENJDK_DL "https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="MAC_X86_64"   %dk_call% dk_set OPENJDK_DL "https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64"   %dk_call% dk_set OPENJDK_DL "https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip"
	if not defined OPENJDK_DL %dk_call% dk_error "OPENJDK_DL is invalid"
	
	%dk_call% dk_basename %OPENJDK_DL% OPENJDK_DL_FILE
	%dk_call% dk_removeExtension %OPENJDK_DL_FILE% OPENJDK_FOLDER
	::%dk_call% dk_convertToCIdentifier %OPENJDK_FOLDER% OPENJDK_FOLDER
	%dk_call% dk_toLower %OPENJDK_FOLDER% OPENJDK_FOLDER
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_set OPENJDK %DK3RDPARTY_DIR%\%OPENJDK_FOLDER%
	%dk_call% dk_set registerJDK11 %OPENJDK%\registerJDK.cmd
	%dk_call% dk_getNativePath %OPENJDK% OPENJDK_NATIVE
	
	if "%HOST_OS%"=="WIN"   (%dk_call% :dk_installOpenJdkWin)
	if "%HOST_OS%"=="MAC"   (%dk_call% :dk_installOpenJdkMac)
	if "%HOST_OS%"=="LINUX" (%dk_call% :dk_installOpenJdkLinux)
%endfunction%	
	
:dk_installOpenJdkWin
	%dk_call% dk_set JAVA_VERSION 11
	%dk_call% dk_set JAVA_VERSION %JAVA_VERSION%
	%dk_call% dk_set JAVA_HOME %OPENJDK%
	setx JAVA_VERSION %JAVA_VERSION%
	setx JAVA_HOME %OPENJDK%
	setx VS_JavaHome %OPENJDK%
	setx STUDIO_JDK %OPENJDK%
	setx STUDIO_GRADLE_JDK %OPENJDK%
	%dk_call% dk_registrySetKey "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment" "CurrentVersion" "REG_SZ" "%JAVA_VERSION%"
	%dk_call% dk_registrySetKey "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\%JAVA_VERSION%" "JavaHome" "REG_SZ" "\"%OPENJDK%\""
	%dk_call% dk_registrySetKey "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\%JAVA_VERSION%" "RuntimeLib" "REG_SZ" "\"%OPENJDK%\\bin\\server\\jvm.dll\""
	
	:::::: Set Environment Variables ::::::
	%dk_call% dk_setEnv JAVA_VERSION %JAVA_VERSION%
	%dk_call% dk_setEnv JAVA_HOME "%OPENJDK_8U41_WINPATH%"
	%dk_call% dk_setEnv VS_JavaHome "%OPENJDK_8U41_WINPATH%"
	%dk_call% dk_setEnv STUDIO_JDK "%OPENJDK_8U41_WINPATH%"
	%dk_call% dk_setEnv STUDIO_GRADLE_JDK "%OPENJDK_8U41_WINPATH%"
%endfunction%

:dk_installOpenJdkMac
	if exist "/Library/Java/JavaVirtualMachines/jdk-11.jdk" goto:eof

	%dk_call% dk_download %OPENJDK_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_command tar xf %DKDOWNLOAD_DIR%/%OPENJDK_DL_FILE%
	%dk_call% dk_command sudo mv %DKDOWNLOAD_DIR%/jdk-11.jdk /Library/Java/JavaVirtualMachines/
	%dk_call% dk_delete %DKDOWNLOAD_DIR%/%OPENJDK_DL_FILE%
	%dk_call% dk_command java --version 
%endfunction%

:dk_installOpenJdkLinux
	::if exist /usr (
	::	%dk_call% dk_set CURRENT_DIR /usr
	::)
	
	::if "%HOST_OS%"=="ANDROID" (
	::	%dk_call% dk_set SUDO ""
	::	%dk_call% dk_set APT "apt"
	::) else (
	::	%dk_call% dk_set SUDO "sudo"
	::	%dk_call% dk_set APT "apt-get"
	::)
	
	if "%HOST_OS%"=="ANDROID" (
		%dk_call% dk_command pkg install openjdk-17 -y
	) else (
		%dk_call% dk_command %SUDO% apt update
		%dk_call% dk_command %SUDO% apt -y install openjdk-11-jdk
	)
	
	%dk_call% dk_command java --version
%endfunction%









::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installOpenjdk
%endfunction%