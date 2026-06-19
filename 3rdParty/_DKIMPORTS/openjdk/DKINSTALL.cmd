rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # DKINSTALL
rem # https://jdk.java.net/archive/
rem # https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz
rem # https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz
rem # https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip
rem # 
:DKINSTALL
rem %setlocal%
	
	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
rem 	if defined Android_Host      	(set "openjdk_Import=openjdk-17")
rem 	if NOT defined openjdk_Import	(%dk_call% dk_error "openjdk_Import is invalid")

	%dk_call% dk_import 
	
	if NOT defined openjdk (%dk_call% dk_importVariables %openjdk_Import%)
	
	set "java_exe=%openjdk%/bin/java.exe"
	set "javac_exe=%openjdk%/bin/javac.exe"
	%dk_call% dk_set registerJDK11 %openjdk%\registerJDK.cmd
	%dk_call% dk_pathToNative %openjdk% openjdk_native
	
	if defined Windows_Host (%dk_call% :dk_installOpenJdkWin)
	if defined Mac_Host   	(%dk_call% :dk_installOpenJdkMac)
	if defined Linux_Host 	(%dk_call% :dk_installOpenJdkLinux)
%endfunction%	
	
:dk_installOpenJdkWin
	%dk_call% dk_set JAVA_VERSION 11
	%dk_call% dk_set JAVA_VERSION %JAVA_VERSION%
	%dk_call% dk_set JAVA_HOME %openjdk%
	
	rem ###### Set Perminent Environment Variables ######
	rem %dk_call% dk_setx JAVA_VERSION %JAVA_VERSION%
	rem %dk_call% dk_setx JAVA_HOME "%openjdk_8_WINPATH%"
	rem %dk_call% dk_setx VS_JavaHome "%openjdk_8_WINPATH%"
	rem %dk_call% dk_setx STUDIO_JDK "%openjdk_8_WINPATH%"
	rem %dk_call% dk_setx STUDIO_GRADLE_JDK "%openjdk_8_WINPATH%"
	%dk_call% setx.exe JAVA_VERSION %JAVA_VERSION%
	%dk_call% setx.exe JAVA_HOME %openjdk%
	%dk_call% setx.exe VS_JavaHome %openjdk%
	%dk_call% setx.exe STUDIO_JDK %openjdk%
	%dk_call% setx.exe STUDIO_GRADLE_JDK %openjdk%
	%dk_call% dk_registrySetKey "HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "REG_SZ" "%JAVA_VERSION%"
	%dk_call% dk_registrySetKey "HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/%JAVA_VERSION%" "JavaHome" "REG_SZ" "\"%openjdk%\""
	%dk_call% dk_registrySetKey "HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/%JAVA_VERSION%" "RuntimeLib" "REG_SZ" "\"%openjdk%\\bin\\server\\jvm.dll\""
%endfunction%

:dk_installOpenJdkMac
	if EXIST "/Library/Java/JavaVirtualMachines/jdk-11.jdk" (%return%)

	%dk_call% dk_download %openjdk_Import%
	%dk_call% dk_command tar xf "%dk_download%"
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_command sudo mv %DKDOWNLOAD_DIR%/jdk-11.jdk /Library/Java/JavaVirtualMachines/
	%dk_call% dk_delete "%dk_download%"
	%dk_call% dk_command java --version
%endfunction%

:dk_installOpenJdkLinux
	rem if EXIST /usr (
	rem 	%dk_call% dk_set CURRENT_DIR /usr
	rem )
	
	if defined Android_Host (
		%dk_call% dk_command pkg install openjdk-17 -y
	) else (
		%dk_call% dk_validate sudo_exe %dk_call% dk_depend sudo_exe
		%dk_call% dk_command %sudo_exe% apt update
		%dk_call% dk_command %sudo_exe% apt -y install openjdk-11-jdk
	)
	
	%dk_call% dk_command java --version
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate openjdk %dk_call% dk_depend openjdk
	%dk_call% dk_debug "java_exe = '%java_exe%'"
	%dk_call% dk_debug "javac_exe = '%javac_exe%'"
	
	%dk_call% dk_validate openjdk %dk_call% dk_depend openjdk
	%dk_call% dk_debug "java_exe = '%java_exe%'"
	%dk_call% dk_debug "javac_exe = '%javac_exe%'"
%endfunction%