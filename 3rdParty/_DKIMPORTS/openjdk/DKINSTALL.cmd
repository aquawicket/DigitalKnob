@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
::#    Reference: https://jdk.java.net/archive/
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined android_host      	(set "OPENJDK_DL=openjdk-17")
	if defined linux_x86_64_host 	(set "OPENJDK_DL=https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz")
	if defined mac_x86_64_host   	(set "OPENJDK_DL=https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz")
	if defined win_x86_64_host   	(set "OPENJDK_DL=https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip")
	if not defined OPENJDK_DL		(%dk_call% dk_error "OPENJDK_DL is invalid")
	
	::%dk_call% dk_basename %OPENJDK_DL% OPENJDK_DL_FILE
	::%dk_call% dk_removeExtension %OPENJDK_DL_FILE% OPENJDK_FOLDER
	::%dk_call% dk_convertToCIdentifier %OPENJDK_FOLDER% OPENJDK_FOLDER
	::%dk_call% dk_toLower %OPENJDK_FOLDER% OPENJDK_FOLDER
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	if not defined OPENJDK (%dk_call% dk_importVariables %OPENJDK_DL% NAME openjdk ROOT %DK3RDPARTY_DIR%)
	
	::%dk_call% dk_set OPENJDK %DK3RDPARTY_DIR%\%OPENJDK_FOLDER%
	%dk_call% dk_set registerJDK11 %OPENJDK%\registerJDK.cmd
	%dk_call% dk_nativePath %OPENJDK% OPENJDK_NATIVE
	
	if defined win_host   (%dk_call% :dk_installOpenJdkWin)
	if defined mac_host   (%dk_call% :dk_installOpenJdkMac)
	if defined linux_host (%dk_call% :dk_installOpenJdkLinux)
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
	
	::###### Set Environment Variables ######
	%dk_call% dk_setEnv JAVA_VERSION %JAVA_VERSION%
	%dk_call% dk_setEnv JAVA_HOME "%OPENJDK_8_WINPATH%"
	%dk_call% dk_setEnv VS_JavaHome "%OPENJDK_8_WINPATH%"
	%dk_call% dk_setEnv STUDIO_JDK "%OPENJDK_8_WINPATH%"
	%dk_call% dk_setEnv STUDIO_GRADLE_JDK "%OPENJDK_8_WINPATH%"
%endfunction%

:dk_installOpenJdkMac
	if exist "/Library/Java/JavaVirtualMachines/jdk-11.jdk" (%return%)

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
	
	::if defined android_host (
	::	%dk_call% dk_set SUDO ""
	::	%dk_call% dk_set APT "apt"
	::) else (
	::	%dk_call% dk_set SUDO "sudo"
	::	%dk_call% dk_set APT "apt-get"
	::)
	
	if defined android_host (
		%dk_call% dk_command pkg install openjdk-17 -y
	) else (
		%dk_call% dk_command %SUDO% apt update
		%dk_call% dk_command %SUDO% apt -y install openjdk-11-jdk
	)
	
	%dk_call% dk_command java --version
%endfunction%









::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%