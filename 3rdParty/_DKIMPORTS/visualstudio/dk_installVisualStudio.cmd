@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installVisualStudio()
::#
::#
:dk_installVisualStudio
	call dk_debugFunc 0	
	
	::### VERSION ###
	%dk_call% dk_set 	VISUALSTUDIO_VERSION 	17
	%dk_call% dk_set 	VISUALSTUDIO_DL 		"https://aka.ms/vs/%VISUALSTUDIO_VERSION%/release/vs_community.exe"
	%dk_call% dk_assert ProgramFiles
	%dk_call% dk_set 	VISUALSTUDIO 			"%ProgramFiles%/Microsoft Visual Studio"

%endfunction%

:get_visualstudio_year result
	::file(GLOB children RELATIVE "${VISUALSTUDIO}" "${VISUALSTUDIO}/*")
	::foreach(child ${children})
	::	if(IS_DIRECTORY "${VISUALSTUDIO}/${child}")
	::		if(EXISTS "${VISUALSTUDIO}/${child}/Community")
	::			set(${result} ${child})
	::			dk_printVar(${result})
	::		endif()
	::	endif()
	::endforeach()
	::if(NOT ${result})
	::	dk_fatal("get_visualstudio_year() Could not locate year.")
	::endif()
	
	%dk_call% dk_getDirectories "%VISUALSTUDIO%" directories
	set /a "n=0"
    :loop1
        if not defined directories[%n%] %return%
		if exist !directories[%n%]!\Community endlocal & set %1=!directories[%n%]!
        set /A n+=1
    goto :loop1 
%endfunction%

:get_visualstudio_edition result
	::file(GLOB children RELATIVE "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC" "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/*")
	::foreach(child ${children})
	::	if(IS_DIRECTORY "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${child}")
	::		if(EXISTS "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${child}/bin/Hostx86")
	::			set(${result} ${child})
	::			dk_printVar(${result})
	::		endif()
	::	endif()
	::endforeach()
	::if(NOT ${result})
	::	dk_fatal("get_visualstudio_edition() Could not locate edition.")
	::endif()
	
	%dk_call% dk_getDirectories "%VISUALSTUDIO_COMMUNITY%\VC\Tools\MSVC" directoriesB
	set /a "n=0"
    :loop2
        if not defined directoriesB[%n%] %return%
		if exist !directories[%n%]!\bin\Hostx86 endlocal & set %1=!directoriesB[%n%]!
        set /A n+=1
    goto :loop2
%endfunction%


::###### INSTALL Visual Studio ######	
if NOT exist %VISUALSTUDIO% (
	%dk_call% dk_info "Installing Visual Studio . . ."
	if exist "%DKDOWNLOAD_DIR%\VisualStudio\vs_setup.exe" (
		"%DK3RDPARTY_DIR%\_DKIMPORTS\visualstudio\InstallVisualStudio.cmd"              &:: offline installer
	) else (
		%dk_call% dk_download "%VISUALSTUDIO_DL%" "%DKDOWNLOAD_DIR%/vs_Community.exe"   &:: online installer
		"%DKDOWNLOAD_DIR%/vs_Community.exe"
	)
) else (
	%dk_call% dk_info "Visual Studio %VISUALSTUDIO_VERSION% %VISUALSTUDIO_YEAR% already installed"
)


::###### set VISUALSTUDIO variables ######
call :get_visualstudio_year VISUALSTUDIO_YEAR
%dk_call% dk_set VISUALSTUDIO_COMMUNITY 				"%VISUALSTUDIO%\%VISUALSTUDIO_YEAR%\Community"
call:     get_visualstudio_edition 						VISUALSTUDIO_EDITION
%dk_call% dk_set VISUALSTUDIO_GENERATOR 				"Visual Studio %VISUALSTUDIO_VERSION% %VISUALSTUDIO_YEAR%"
%dk_call% dk_set VISUALSTUDIO_MAKE_PROGRAM				"%VISUALSTUDIO_COMMUNITY%\MSBuild\Current\Bin\amd64\MSBuild.exe"
%dk_call% dk_set VISUALSTUDIO_X86_COMPILER 				"%VISUALSTUDIO_COMMUNITY%\VC\Tools\MSVC\%VISUALSTUDIO_EDITION%\bin\Hostx64\x86\cl.exe"
%dk_call% dk_set VISUALSTUDIO_X64_COMPILER 				"%VISUALSTUDIO_COMMUNITY%\VC\Tools\MSVC\%VISUALSTUDIO_EDITION%\bin\Hostx64\x64\cl.exe"
%dk_call% dk_set VISUALSTUDIO_X86_LINKER 				"%VISUALSTUDIO_COMMUNITY%\VC\Tools\MSVC\%VISUALSTUDIO_EDITION%\bin\Hostx64\x86\link.exe"
%dk_call% dk_set VISUALSTUDIO_X64_LINKER 				"%VISUALSTUDIO_COMMUNITY%\VC\Tools\MSVC\%VISUALSTUDIO_EDITION%\bin\Hostx64\x64\link.exe"
%dk_call% dk_set VISUALSTUDIO_X86_DUMPBIN 				"%VISUALSTUDIO_COMMUNITY%\VC\Tools\MSVC\%VISUALSTUDIO_EDITION%\bin\Hostx86\x86\dumpbin.exe"
%dk_call% dk_set VISUALSTUDIO_X64_DUMPBIN 				"%VISUALSTUDIO_COMMUNITY%\VC\Tools\MSVC\%VISUALSTUDIO_EDITION%\bin\Hostx86\x64\dumpbin.exe"
if defined ARM64  %dk_call% dk_set VISUALSTUDIO_GENERATOR_PLATFORM   ARM64
if defined X86 (
	%dk_call% dk_set VISUALSTUDIO_GENERATOR_PLATFORM	Win32)
	%dk_call% dk_set VISUALSTUDIO_C_COMPILER			"%VISUALSTUDIO_X86_COMPILER%"
	%dk_call% dk_set VISUALSTUDIO_CXX_COMPILER			"%VISUALSTUDIO_X86_COMPILER%"
	%dk_call% dk_set VISUALSTUDIO_LINKER				"%VISUALSTUDIO_X86_LINKER%"
	%dk_call% dk_set VISUALSTUDIO_DUMPBIN				"%VISUALSTUDIO_X86_DUMPBIN%"
)
if defeind X86_64 {
	%dk_call% dk_set VISUALSTUDIO_GENERATOR_PLATFORM	x64)
	%dk_call% dk_set VISUALSTUDIO_C_COMPILER			"%VISUALSTUDIO_X64_COMPILER%"
	%dk_call% dk_set VISUALSTUDIO_CXX_COMPILER			"%VISUALSTUDIO_X64_COMPILER%"
	%dk_call% dk_set VISUALSTUDIO_LINKER				"%VISUALSTUDIO_X64_LINKER%"
	%dk_call% dk_set VISUALSTUDIO_DUMPBIN				"%VISUALSTUDIO_X64_DUMPBIN%"
) else (
	%dk_call% dk_fatal "Could not determin TARGET_ARCH to set VISUALSTUDIO variables"
)


::###### Patch Android Files ######
if defined ANDROID (
	if exist "%VISUALSTUDIO_COMMUNITY%\MSBuild\Microsoft\MDD\Android\V150\Android.Common.targets" (
		%dk_call% dk_info "Patching Android.Common.targets. . ."
		%dk_call% dk_fileReplace "%VISUALSTUDIO_COMMUNITY%\MSBuild\Microsoft\MDD\Android\V150\Android.Common.targets" ">ARM7</GradlePlatform>" "></GradlePlatform>")
		%dk_call% dk_fileReplace "%VISUALSTUDIO_COMMUNITY%\MSBuild\Microsoft\MDD\Android\V150\Android.Common.targets" ">ARM8</GradlePlatform>" "></GradlePlatform>")
		%dk_call% dk_fileReplace "%VISUALSTUDIO_COMMUNITY%\MSBuild\Microsoft\MDD\Android\V150\Android.Common.targets" ">x86-64</GradlePlatform>" "></GradlePlatform>")
	) else (
		%dk_call% dk_fatal "%VISUALSTUDIO_COMMUNITY%\MSBuild\Microsoft\MDD\Android\V150\Android.Common.targets does not exist!"
	)
)











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installVisualStudio
%endfunction%