@echo off
::############# DigitalKnob builder script ############

setlocal EnableDelayedExpansion

::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


::### call any arguments passed in ###
echo %0(%*)
if "%*" neq "" call %* 
    
::# https://stackoverflow.com/a/4095133/688352

::--------------------------------------------------------
:: convert line endings
::--------------------------------------------------------
::if '%~nx0'=='build.cmd' (
::    more /P build.cmd >build_crlf.cmd
::    del build.cmd & rename build_crlf.cmd build.cmd
::)

::--------------------------------------------------------
:: enable escape sequence console colors
:: https://superuser.com/a/1300251
::--------------------------------------------------------
::REG ADD HKCU\CONSOLE /f /v VirtualTerminalLevel /t REG_DWORD /d 1


::###### Global Script Variables ######
::[ -z ${RELOAD_WITH_BASH-} ] && export RELOAD_WITH_BASH=1
set LOG_VERBOSE=1
set LOG_DEBUG=1
set TRACE_ON_WARNINGS=0
set HALT_ON_WARNINGS=0
set CONTINUE_ON_ERRORS=0
set DKSCRIPT_DIR=%~dp0
set DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%
set DKSCRIPT_NAME=%~nx0
::set true=0
::set false=1
set "clr=[0m"
set "black=[30m"
set "red=[31m"
set "green=[32m"
set "yellow=[33m"
set "blue=[34m"
set "magenta=[35m"
set "cyan=[36m"
set "white=[37m"

set "CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip"
set "CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip"
set "CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip"
set "CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz"
::set "CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz"
set "CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz"
set "CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz"

set GIT_DL_WIN_X86=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe
set GIT_DL_WIN_X86_64=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe


::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain () {
	call:dk_verbose "dk_buildMain(%*)"
	
::	echo "BASH = $BASH"
::	if [ $RELOAD_WITH_BASH = 1 ]; then # && ! dk_defined BASH; then
::		export RELOAD_WITH_BASH=0
::		dk_commandExists bash && exec /bin/bash "$0" # Change to bash
::	fi
::	::export PS4=$'+\e[33m ${BASH_SOURCE[0]:-nofile}:${BASH_LINENO[0]:-noline} ${FUNCNAME[0]:-nofunc}()\e[0m  '
::
::	::###### Set and check posix mode ######
::	$(set -o posix) && set -o posix && case :$SHELLOPTS: in
::	  *:posix:*) echo "POSIX mode enabled" ;;
::	  *)         echo "POSIX mode not enabled" ;;
::	esac
::	$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
::	$(set -o errtrace) && set -o errtrace 	# trace ERR through 'time command' and other functions
::	::$(set -o nounset) && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
::	::$(set -o errexit) && set -o errexit  	# set -e : exit the script if any statement returns a non-true
::
::	:: log to stdout and file
::	::exec |& tee file.log 
	
	::call:dk_validate_sudo
	
::	if dk_defined WSLENV; then 
::		call:dk_info "WSLENV is on"
::		call:dk_info "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
::		sudo chown -R "$LOGNAME" "$HOME"
::	fi
	
::	if [ -n "${USER-}" ]; then
::		call:dk_printVar USER
::		DKUSERNAME=$USER
::	elif [ -n "${USERNAME-}" ]; then
::		call:dk_printVar USERNAME
::		DKUSERNAME=$USERNAME
::	fi
::	dk_printVar DKUSERNAME
	
::	call:dk_printVar SHLVL
::  call:dk_printVar MSYSTEM
	call:dk_printVar DKSCRIPT_NAME
	call:dk_printVar DKSCRIPT_DIR

	:::::: Get the HOST_TRIPLE and other HOST variables
	call:dk_getHostTriple

	call:dk_getDKPaths
   
    call:dk_validateGit
    call:dk_validateBranch

    call:dk_printVar DKBRANCH_DIR
    call:dk_printVar DKAPPS_DIR
    call:dk_printVar DKCMAKE_DIR
    call:dk_printVar DK3RDPARTY_DIR
    call:dk_printVar DKIMPORTS_DIR
    call:dk_printVar DKPLUGINS_DIR
    
	if NOT "%DKSCRIPT_DIR%"=="%DKBRANCH_DIR%" (
		call:dk_warning "%DKSCRIPT_NAME% is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		call:dk_warning "%DKSCRIPT_NAME% path = %DKSCRIPT_DIR%"
		call:dk_warning "DKBRANCH_DIR path = %DKBRANCH_DIR%"
	)
    
    :while_loop             
	
		if "%UPDATE%"==""     call:dk_pickUpdate & goto:while_loop
		if "%APP%"==""        call:dk_pickApp    & goto:while_loop
		if "%TARGET_OS%"==""  call:dk_pickOs     & goto:while_loop
		if "%TYPE%"==""       call:dk_pickType   & goto:while_loop

		call:dk_createCache
		
		call:dk_generate
		
		call:dk_build
		
		set UPDATE=
		set APP=
		set TARGET_OS=
		set TYPE=
	goto while_loop
goto:eof


::#####################################################################
::# dk_pickUpdate()
::#
::#
:dk_pickUpdate () {
	call:dk_verbose "dk_pickUpdate(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    
    call:dk_readCache

    echo.
    call:dk_checkGitRemote

    echo.
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_TARGET_OS_%" neq "" if "%_TYPE_%" neq "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
    echo  1) Git Update
    echo  2) Git Commit
    echo  3) Push assets
    echo  4) Pull assets
    echo  5) Reset All
    echo  6) Remove All
    echo  7) Clear Screen
    echo  8) Clear cmake cache and .tmp files
    echo  9) Reload
    echo  10) Exit
    echo. 
    echo  Press Enter To Skip
    set choice=
    set /p "choice=Choose a selection: " 
    
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="0" set "APP=%_APP_%" & set "TARGET_OS=%_TARGET_OS_%" & set "TYPE=%_TYPE_%"
    if "%choice%"=="1" call:dk_gitUpdate
    if "%choice%"=="2" call:dk_gitCommit
    if "%choice%"=="3" call:dk_pushAssets
    if "%choice%"=="4" call:dk_pullAssets
    if "%choice%"=="5" call:dk_resetAll
    if "%choice%"=="6" call:dk_removeAll
    if "%choice%"=="7" call:dk_clearScreen
    if "%choice%"=="8" call:dk_clearCmakeCache & call:dk_deleteTempFiles
    if "%choice%"=="9" call:dk_reload
    if "%choice%"=="10" exit
        
    set UPDATE=true
goto:eof


::#####################################################################
::# dk_pickApp()
::#
::#
:dk_pickApp () {
	call:dk_verbose "dk_pickApp(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%

    call:dk_readCache

    echo.
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_TARGET_OS_%" neq "" if "%_TYPE_%" neq "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
    echo  1) HelloWorld
    echo  2) DKCore
    echo  3) DKJavascript
    echo  4) DKSDL
    echo  5) DKSDLRml
    echo  6) DKDomTest
    echo  7) DKTestAll
    echo  8) Enter Manually
    echo  9) Clear Screen
    echo 10) Reload
    echo 11) Go Back
    echo 12) Exit
    set choice=
    set /p choice=Please select an app to build: 
    
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="0"  set "APP=%_APP_%" & set "TARGET_OS=%_TARGET_OS_%" & set "TYPE=%_TYPE_%" & goto:eof
    if "%choice%"=="1"  set "APP=HelloWorld"   & goto:eof
    if "%choice%"=="2"  set "APP=DKCore"       & goto:eof
    if "%choice%"=="3"  set "APP=DKJavascript" & goto:eof
    if "%choice%"=="4"  set "APP=DKSDL"        & goto:eof
    if "%choice%"=="5"  set "APP=DKSDLRml"     & goto:eof
    if "%choice%"=="6"  set "APP=DKDomTest"    & goto:eof
    if "%choice%"=="7"  set "APP=DKTestAll"    & goto:eof
    if "%choice%"=="8"  call:dk_enterManually    & goto:eof
    if "%choice%"=="9" call:dk_clearScreen       & goto:eof
    if "%choice%"=="10" call:dk_reload            & goto:eof
    if "%choice%"=="11" set "UPDATE="          & goto:eof
    if "%choice%"=="12" exit                   & goto:eof
        
    echo %choice%: invalid selection, please try again
    set APP=
goto:eof


::####################################################################
::# dk_pickOs()
::#
::#
:dk_pickOs () {
	call:dk_verbose "dk_pickOs(%*)"

    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
       
    :: TODO: this list can be created using the DKCMake/toolchains files.
    echo.
    echo  1) %HOST_TRIPLE%
    echo.
    echo  2) Android arm32
    echo  3) Android arm64
    echo  4) Android x86
    echo  5) Android x86_64
    echo  6) Emscripten
    echo  7) Ios arm32
    echo  8) Ios arm64
    echo  9) Ios x86
    echo 10) Ios x86_64
    echo 11) Iossim arm32
    echo 12) Iossim arm64
    echo 13) Iossim x86
    echo 14) Iossim x86_64
    echo 15) Linux arm32
    echo 16) Linux arm64
    echo 17) Linux x86
    echo 18) Linux x86_64
    echo 19) Mac arm32
    echo 20) Mac arm64
    echo 21) Mac x86
    echo 22) Mac x86_64
    echo 23) Raspberry arm32
    echo 24) Raspberry arm64
    echo 25) Raspberry x86
    echo 26) Raspberry x86_64
    echo 27) Windows arm32
    echo 28) Windows arm64 (clang)
    echo 29) Windows x86 (gcc)
    echo 30) Windows x86 (clang)
    echo 31) Windows x86 (msvc)
    echo 32) Windows x86_64 (gcc)
    echo 33) Windows x86_64 (clang)
    echo 34) Windows x86_64 (ucrt)
    echo 35) Windows x86_64 (msvc)
	echo 36) none
    echo 37) Clear Screen
    echo 38) Go Back
    echo 39) Exit    
    set choice=
    set /p choice=Please select an OS to build for: 
        
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="1" set "TARGET_OS=%HOST_TRIPLE%"      & goto:eof
    if "%choice%"=="2" set "TARGET_OS=android_arm32"       & goto:eof
    if "%choice%"=="3" set "TARGET_OS=android_arm64"       & goto:eof
    if "%choice%"=="4" set "TARGET_OS=android_x86"         & goto:eof
    if "%choice%"=="5" set "TARGET_OS=android_x86_64"      & goto:eof
    if "%choice%"=="6" set "TARGET_OS=emscripten"          & goto:eof
    if "%choice%"=="7" set "TARGET_OS=ios_arm32"           & goto:eof
    if "%choice%"=="8" set "TARGET_OS=ios_arm64"           & goto:eof
    if "%choice%"=="9" set "TARGET_OS=ios_x86"             & goto:eof
    if "%choice%"=="10" set "TARGET_OS=ios_x86_64"         & goto:eof
    if "%choice%"=="11" set "TARGET_OS=iossim_arm32"       & goto:eof
    if "%choice%"=="12" set "TARGET_OS=iossim_arm64"       & goto:eof
    if "%choice%"=="13" set "TARGET_OS=iossim_x86"         & goto:eof
    if "%choice%"=="14" set "TARGET_OS=iossim_x86_64"      & goto:eof
    if "%choice%"=="15" set "TARGET_OS=linux_arm32"        & goto:eof
    if "%choice%"=="16" set "TARGET_OS=linux_arm64"        & goto:eof
    if "%choice%"=="17" set "TARGET_OS=linux_x86"          & goto:eof
    if "%choice%"=="18" set "TARGET_OS=linux_x86_64"       & goto:eof
    if "%choice%"=="19" set "TARGET_OS=mac_arm32"          & goto:eof
    if "%choice%"=="20" set "TARGET_OS=mac_arm64"          & goto:eof
    if "%choice%"=="21" set "TARGET_OS=mac_x86"            & goto:eof
    if "%choice%"=="22" set "TARGET_OS=mac_x86_64"         & goto:eof
    if "%choice%"=="23" set "TARGET_OS=raspberry_arm32"    & goto:eof
    if "%choice%"=="24" set "TARGET_OS=raspberry_arm64"    & goto:eof
    if "%choice%"=="25" set "TARGET_OS=raspberry_x86"      & goto:eof
    if "%choice%"=="26" set "TARGET_OS=raspberry_x86_64"   & goto:eof
    if "%choice%"=="27" set "TARGET_OS=win_arm32"          & goto:eof
    if "%choice%"=="28" set "TARGET_OS=win_arm64_clang"    & goto:eof
    if "%choice%"=="29" set "TARGET_OS=win_x86_mingw"      & goto:eof
    if "%choice%"=="30" set "TARGET_OS=win_x86_clang"      & goto:eof
    if "%choice%"=="31" set "TARGET_OS=win_x86_msvc"       & goto:eof
    if "%choice%"=="32" set "TARGET_OS=win_x86_64_mingw"   & goto:eof
    if "%choice%"=="33" set "TARGET_OS=win_x86_64_clang"   & goto:eof
    if "%choice%"=="34" set "TARGET_OS=win_x86_64_ucrt"    & goto:eof
    if "%choice%"=="35" set "TARGET_OS=win_x86_64_msvc"    & goto:eof
	if "%choice%"=="36" set "TARGET_OS=none"               & goto:eof
    if "%choice%"=="37" call:dk_clearScreen                  & goto:eof
    if "%choice%"=="38" set "APP="                         & goto:eof
    if "%choice%"=="39" exit                               & goto:eof
    echo %choice%: invalid selection, please try again
    set TARGET_OS=
goto:eof


::#####################################################################
::# dk_pickType()
::#
::#
:dk_pickType () {
	call:dk_verbose "dk_pickType(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%     
    echo.
    echo 1) Debug
    echo 2) Release
    echo 3) All
	echo 4) none
    echo 5) Clear Screen
    echo 6) Go Back
    echo 7) Exit
    set choice=
    set /p choice=Please select a build type: 
    
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do? 
    if "%choice%"=="1" set "TYPE=Debug"    		& goto:eof
    if "%choice%"=="2" set "TYPE=Release"  		& goto:eof
    if "%choice%"=="3" set "TYPE=All"      		& goto:eof
	if "%choice%"=="4" set "TYPE=none"     		& goto:eof
    if "%choice%"=="5" call:dk_clearScreen		& goto:eof
    if "%choice%"=="6" set "TARGET_OS="			& goto:eof
    if "%choice%"=="7" exit						& goto:eof
        
    echo %choice%: invalid selection, please try again
    set TYPE=
goto:eof


::####################################################################
::# dk_appendCmakeArgs(string)
::#
::#
:dk_appendCmakeArgs () {
	call:dk_verbose "dk_appendCmakeArgs(%*)"
	
    if "%*" == "" echo ERROR: dk_appendCmakeArgs is empty! & goto:eof
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
	echo appended %*
goto:eof


::####################################################################
::# dk_prependCmakeArgs(string)
::#
::#
:dk_prependCmakeArgs () {
	call:dk_verbose "dk_prependCmakeArgs(%*)"
	
    if "%*" == "" echo ERROR: dk_prependCmakeArgs is empty! & goto:eof
    set CMAKE_ARGS="%*" %CMAKE_ARGS%
	echo prepended %*
goto:eof


::####################################################################
::# dk_generate()
::#
::#
:dk_generate () {
	call:dk_verbose "dk_generate(%*)"
	
    TITLE DigitalKnob - Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% . . .
    echo.
	echo ##################################################################
	echo      Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL%
	echo ##################################################################
	echo.
    
    call:dk_clearCmakeCache
    call:dk_deleteTempFiles
    
    ::if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    call:dk_printVar TARGET_PATH
    call:dk_makeDirectory "%TARGET_PATH%\%TARGET_OS%"
    ::cd "%TARGET_PATH%\%TARGET_OS%"
    call set CMAKE_SOURCE_DIR=%%DKCMAKE_DIR:^\=^/%%
    call:dk_printVar CMAKE_SOURCE_DIR
    call set CMAKE_TARGET_PATH=%%TARGET_PATH:^\=^/%%
    call:dk_printVar CMAKE_TARGET_PATH
        
::	############ BUILD CMAKE_ARGS ARRAY ############
    set DKLEVEL=RebuildAll
    set DKLINK=Static

    set CMAKE_ARGS=
    ::if %TYPE%==Debug           call:dk_appendCmakeArgs -DDEBUG=ON & call:dk_appendCmakeArgs -DRELEASE=OFF
    if %TYPE%==Debug             call:dk_appendCmakeArgs -DDEBUG=ON
    ::if %TYPE%==Release         call:dk_appendCmakeArgs -DDEBUG=OFF & call:dk_appendCmakeArgs -DRELEASE=ON
    if %TYPE%==Release           call:dk_appendCmakeArgs -DRELEASE=ON
    if %TYPE%==All               call:dk_appendCmakeArgs -DDEBUG=ON & call:dk_appendCmakeArgs -DRELEASE=ON
    if %DKLEVEL%==Build          call:dk_appendCmakeArgs -DBUILD=ON
    if %DKLEVEL%==Rebuild        call:dk_appendCmakeArgs -DREBUILD=ON
    if %DKLEVEL%==RebuildAll     call:dk_appendCmakeArgs -DREBUILDALL=ON
    if %DKLINK%==Static          call:dk_appendCmakeArgs -DSTATIC=ON
    if %DKLINK%==Shared          call:dk_appendCmakeArgs -DSHARED=ON
    ::if %TARGET_OS%==emscripten call:dk_appendCmakeArgs -DEMSCRIPTEN=ON
        
    set CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%/%TYPE%
    call:dk_printVar CMAKE_BINARY_DIR
        
    call:dk_appendCmakeArgs -S=%CMAKE_SOURCE_DIR%
    call:dk_appendCmakeArgs -B=%CMAKE_BINARY_DIR%

    ::############ CMake Options ############
    ::call:dk_appendCmakeArgs -DCMAKE_VERBOSE_MAKEFILE=1
    ::call:dk_appendCmakeArgs -DCMAKE_COLOR_DIAGNOSTICS=ON
    call:dk_appendCmakeArgs -Wdev
    ::call:dk_appendCmakeArgs -Werror=dev
    call:dk_appendCmakeArgs -Wdeprecated
    ::call:dk_appendCmakeArgs -Werror=deprecated
    ::call:dk_appendCmakeArgs --graphviz=graphviz.txt
    ::call:dk_appendCmakeArgs --system-information system_information.txt
    ::call:dk_appendCmakeArgs --debug-trycompile
    ::call:dk_appendCmakeArgs --debug-output
    ::call:dk_appendCmakeArgs --trace
    ::call:dk_appendCmakeArgs --trace-expand
    ::call:dk_appendCmakeArgs --warn-uninitialized
    call:dk_appendCmakeArgs --warn-unused-vars
    ::call:dk_appendCmakeArgs --check-system-vars
	
	if %TARGET_OS%==android_arm32      call:dk_prependCmakeArgs -G Unix Makefiles
	if %TARGET_OS%==android_arm64      call:dk_prependCmakeArgs -G Unix Makefiles
	if %TARGET_OS%==emscripten         call:dk_prependCmakeArgs -G Unix Makefiles	
	if %TARGET_OS%==ios_arm32          call:dk_prependCmakeArgs -G Xcode
	if %TARGET_OS%==ios_arm64          call:dk_prependCmakeArgs -G Xcode
	if %TARGET_OS%==iossim_x86         call:dk_prependCmakeArgs -G Xcode
	if %TARGET_OS%==iossim_x86_64      call:dk_prependCmakeArgs -G Xcode
	if %TARGET_OS%==linux_x86          call:dk_prependCmakeArgs -G Unix Makefiles
	if %TARGET_OS%==linux_x86_64       call:dk_prependCmakeArgs -G Unix Makefiles
	if %TARGET_OS%==mac_x86            call:dk_prependCmakeArgs -G Xcode
	if %TARGET_OS%==mac_x86_64         call:dk_prependCmakeArgs -G Xcode
	if %TARGET_OS%==raspberry_arm32    call:dk_prependCmakeArgs -G Unix Makefiles
	if %TARGET_OS%==raspberry_arm64    call:dk_prependCmakeArgs -G Unix Makefiles
	if %TARGET_OS%==win_arm64_clang    call:dk_prependCmakeArgs -G MinGW Makefiles
	if %TARGET_OS%==win_x86_clang      call:dk_prependCmakeArgs -G MinGW Makefiles
	if %TARGET_OS%==win_x86_mingw      call:dk_prependCmakeArgs -G MinGW Makefiles
	if %TARGET_OS%==win_x86_64_clang   call:dk_prependCmakeArgs -G MinGW Makefiles
	if %TARGET_OS%==win_x86_64_mingw   call:dk_prependCmakeArgs -G MinGW Makefiles
	if %TARGET_OS%==win_x86_64_ucrt    call:dk_prependCmakeArgs -G MinGW Makefiles
	
::	###### CMAKE_TOOLCHAIN_FILE ######
::	set TOOLCHAIN=%DKCMAKE_DIR%\toolchains\%TARGET_OS%_toolchain.cmake
::	echo "TOOLCHAIN = %TOOLCHAIN%"
::	set TOOLCHAIN_FILE=%%TOOLCHAIN:^\=^/%%
::	if exist %TOOLCHAIN% call:dk_appendCmakeArgs -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN_FILE%
    
	
::	###### WSL CMake Fix ######
::  if dk_defined WSLENV; then 
::		cd "$DKCMAKE_DIR"
::		set -- "$@" "."
::	fi
	
::	###### CMake Configure ######
	call:dk_validateCmake
	
    echo.
    echo ****** CMAKE COMMAND ******
    echo "%CMAKE_EXE%" %CMAKE_ARGS%
    "%CMAKE_EXE%" %CMAKE_ARGS%
    echo.
goto:eof


::#####################################################################
::# dk_build()
::#
::#
:dk_build () {
	call:dk_verbose "dk_build(%*)"
	
    TITLE DigitalKnob - Building %APP% - %TARGET_OS% -%TYPE% - %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
	
	if %TYPE%==All      call:dk_buildAll
	if %TYPE%==Release  call:dk_buildRelease
	if %TYPE%==Debug    call:dk_buildDebug
	
	echo.
    echo ###########################################################        
    echo ****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
goto:eof


:dk_buildAll () {
::####################################################################
::# dk_buildDebug()
::#
::#
:dk_buildDebug () {
	call:dk_verbose "dk_buildDebug(%*)"
	
    if "%MSYSTEM%" neq "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Debug\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose
        goto:eof
    )
goto:eof


::####################################################################
::# dk_buildRelease()
::#
::#
:dk_buildRelease () {
	call:dk_verbose "dk_buildRelease(%*)"
	
    if "%MSYSTEM%" neq "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Release --config Debug --verbose"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Release\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose
        goto:eof
    )
goto:eof



::####################################################################
:: DKBatch FUNCTIONS
:: https://www.dostips.com/DtTutoFunctions.php
::####################################################################

::####################################################################
::# dk_getParentFolder(input, rtn_var)
::#
::#
:dk_getParentFolder () {
	call:dk_verbose "dk_getParentFolder(%*)"
	
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
goto:eof


::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths () {
	call:dk_verbose "dk_getDKPaths(%*)"
	
	
	
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
    call:dk_makeDirectory "%DIGITALKNOB_DIR%"
    call:dk_printVar DIGITALKNOB_DIR






    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    call:dk_makeDirectory "%DKTOOLS_DIR%"
    call:dk_printVar DKTOOLS_DIR
        
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    call:dk_makeDirectory "%DKDOWNLOAD_DIR%"
    call:dk_printVar DKDOWNLOAD_DIR
goto:eof


::#####################################################################
::# dk_getParentDir(input, rtn_var)
::#
::#
:dk_getParentDir () {
	call:dk_verbose "dk_getParentDir(%*)"
	
	for %%A in (%1.) do set "parent=%%~dpA"
    set "%2=%parent%"
goto:eof


::#####################################################################
::# dk_getHostTriple()
::#
::#
:dk_getHostTriple () {
	call:dk_verbose "dk_getHostTriple(%*)"
	
	set HOST_OS=win
    call:dk_printVar HOST_OS
	
	if %PROCESSOR_ARCHITECTURE%==x86 set HOST_ARCH=x86
    if %PROCESSOR_ARCHITECTURE%==AMD64 set HOST_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==IA64  set HOST_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==EM64T set HOST_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==ARM64  set HOST_ARCH=arm64
    call:dk_printVar HOST_ARCH
	
	set HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%
    call:dk_printVar HOST_TRIPLE
    
    set HOST_ENV=clang
    set HOST_TRIPLE=%HOST_TRIPLE%_%HOST_ENV%
	call:dk_printVar HOST_TRIPLE
goto:eof


::##################################################################################
::# dk_checkGitRemote()
::#
::#
:dk_checkGitRemote () {
	call:dk_verbose "dk_checkGitRemote(%*)"
	
    if not exist "%DKBRANCH_DIR%\.git" goto:eof
    
    :: git remote update >nul 2>&1
    %GIT_EXE% remote update
    
    :: branch= $(git rev-parse --abbrev-ref HEAD)
    call:dk_commandToVariable "%GIT_EXE% rev-parse --abbrev-ref HEAD" branch
    
    :: ahead= $(git rev-list --count origin/$branch..$branch)
    call:dk_commandToVariable "%GIT_EXE% rev-list --count origin/%branch%..%branch%" ahead
        
    :: behind= $(git rev-list --count $branch..origin/$branch)
    call:dk_commandToVariable "%GIT_EXE% rev-list --count %branch%..origin/%branch%" behind
    
    echo %ahead% commits ahead, %behind% commits behind
goto:eof


::####################################################################
::# dk_call()
::#
::#
:dk_call () {
	call:dk_verbose "dk_call(%*)"
	
    ::TODO
    :: Here we try to use DK_call to pass on a call while echoing the call passed
    :: This works in bash script, yet we have issues with this in cmd
    echo %*
    %*
goto:eof


::####################################################################
::# dk_enterManually()
::#
::#
:dk_enterManually () {
	call:dk_verbose "dk_enterManually(%*)"
	
    echo Please type the name of the library, tool or app to build. Then press enter.
    set /p input= 

    set APP=_%input%_
  
    ::Search digitalknob for the matching entry containing a DKMAKE.cmake file  
    ::cd %DIGITALKNOB_DIR%
    ::for /f "delims=" %%a in ('dir /b /s /a-d DKMAKE.cmake ^| findstr /E /R "%input%\\DKMAKE.cmake" ') do set "path=%%a"
    ::set "TARGET_PATH=%path:~0,-13%"
    
    if exist "%DKIMPORTS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKIMPORTS_DIR%\%input%"
    if exist "%DKPLUGINS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKPLUGINS_DIR%\%input%"
    if exist "%DKAPPS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKAPPS_DIR%\%input%"
    ::call:dk_printVar TARGET_PATH
    
    call:dk_getParentFolder %TARGET_PATH% parent
    ::call:dk_printVar parent
    
    if %parent%==DKApps goto:eof
    call:dk_makeDirectory  %DKAPPS_DIR%\%APP%
    
    :: create DKApps/<APP>/DKMAKE.cmake 
    echo dk_depend(%input%)> %DKAPPS_DIR%\%APP%\DKMAKE.cmake
    
    :: create DKApps/<APP>/main.cpp
    echo int main(int argc, char** argv) { return 0; } > %DKAPPS_DIR%\%APP%\main.cpp
goto:eof


::####################################################################
::# dk_pushAssets()
::#
::#
:dk_pushAssets () {
	call:dk_verbose "dk_pushAssets(%*)"
	
    echo not implemented,  TODO
goto:eof


::####################################################################
::# dk_pullAssets()
::#
::#
:dk_pullAssets () {
	call:dk_verbose "dk_pullAssets(%*)"
	
    echo not implemented,  TODO
goto:eof


::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps () {
	call:dk_verbose "dk_resetApps(%*)"
	
    echo Resetting Apps . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" neq "Y" goto:eof

    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof


::####################################################################
::# dk_resetPlugins()
::#
::#
:dk_resetPlugins () {
	call:dk_verbose "dk_resetPlugins(%*)"
	
    echo Resetting DKPlugins . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" neq "Y" goto:eof
        
    cd %DKPLUGINS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof


::####################################################################
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty () {
	call:dk_verbose "dk_reset3rdparty(%*)"
	
    echo Resetting 3rdParty Libraries . . .
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" neq "Y" goto:eof
        
    cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof


::####################################################################
::# dk_resetAll()
::#
::#
:dk_resetAll () {
	call:dk_verbose "dk_resetAll(%*)"
	
    if "%1" equ "wipe" goto:wipe
        
    cls
    echo.
    echo.
    echo  Do you want to reset the entire local repository . . .?
    echo. This will delete digitalknob, everything will be reset,
    echo. and the repository will be re-cloned. All libraries and tools
    echo. will be redownloaded and rebuild from start. Save any changes 
    echo. you wish to commit or save beforehand.
    echo. 
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" neq "Y" goto:eof
        
    :: first we need to relocate this file up one directory
    :: make sure script is running from DKBRANCH_DIR
    if not "%DKSCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        echo WARNING: this file isn't running from the branch directory
        echo Is must be in the branch directory to continue.
        call:dk_printVar DKSCRIPT_DIR
        call:dk_printVar DKBRANCH_DIR
        goto:eof
    )
    
    call:dk_killProcess java.exe
    call:dk_killProcess adb.exe
    
    echo "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%"
    copy /Y %DKSCRIPT_DIR%\%DKSCRIPT_NAME% %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%
    start "" "%DIGITALKNOB_DIR%\%DKSCRIPT_NAME%" :dk_resetAll wipe
    exit    
        
::	###################################################################
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd
    ::do we need to uninstall any apps?
    ::do we need to remove any environment variables?
      
    :: TODO: kill java.exe processes
    :: TODO: kill adb.exe process
      
    cd %DIGITALKNOB_DIR%

    echo.
    echo DELETING %DKBRANCH_DIR% . . . .
    call rmdir %DKBRANCH_DIR% /s /q
    echo done.
        
    :: wait for the folders to get deleted
    ping 127.0.0.1 -n 6 >nul
    ping 127.0.0.1 -n 6 >nul
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
        
    call:dk_gitUpdate NO_CONFIRM
        
    start "" "%DKBRANCH_DIR%\%DKSCRIPT_NAME%" & del /f %DIGITALKNOB_DIR%\%DKSCRIPT_NAME% & exit
goto:eof


::####################################################################
::# dk_removeAll()
::#
::#
:dk_removeAll () {
	call:dk_verbose "dk_removeAll(%*)"
	
    if "%1" equ "wipe" goto:wipe
        
    cls
    echo.
    echo.
    echo  Do you want to remove the entire local repository . . .?
    echo. This will delete digitalknob. Save any changes 
    echo. you wish to commit or save beforehand.
    echo. 
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" neq "Y" goto:eof
        
    :: first we need to relocate this file up one directory
    :: make sure script is running from DKBRANCH_DIR
    if not "%DKSCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        echo WARNING: this file isn't running from the branch directory
        echo Is must be in the branch directory to continue.
        call:dk_printVar DKSCRIPT_DIR
        call:dk_printVar DKBRANCH_DIR
        goto:eof
    )
    
    call:dk_killProcess java.exe
    call:dk_killProcess adb.exe
    
    echo "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%"
    copy /Y %DKSCRIPT_DIR%\%DKSCRIPT_NAME% %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%
    start "" "%DIGITALKNOB_DIR%\%DKSCRIPT_NAME%" :dk_removeAll wipe
    exit    
        
::  ##################################################################
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd   
    ::do we need to kill any processes? 
    ::do we need to uninstall any apps?  
    ::do we need to remove any environment variables?
        
    cd %DIGITALKNOB_DIR%
    echo.
    echo DELETING %DKBRANCH_DIR% . . . .
    call rmdir %DKBRANCH_DIR% /s /q
    echo done.
        
    :: wait for the folders to get deleted
    ping 127.0.0.1 -n 6 >nul
    ping 127.0.0.1 -n 6 >nul
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
goto:eof


::####################################################################
::# dk_reload()
::#
::#
:dk_reload () {
	call:dk_verbose "dk_reload(%*)"
	
    echo .
    echo reloading %DKSCRIPT_NAME%
    start "" "%DKSCRIPT_DIR%\%DKSCRIPT_NAME%"
    exit
goto:eof


::####################################################################
::# dk_checkError()
::#
::#
:dk_checkError () {
	call:dk_verbose "dk_checkError(%*)"
	
    if %ERRORLEVEL% equ 0 goto:eof
    call:dk_error "ERRORLEVEL = %ERRORLEVEL%"
    pause
    exit
goto:eof


::####################################################################
::# dk_download(url, destination)
::#
::#
:dk_download () {
	call:dk_verbose "dk_download(%*)"
	
    echo Downloading %~1
    if exist "%~2" (
        echo %~2 already exist
        goto:eof
    )

    echo please wait . . .
    ::certutil.exe -urlcache -split -f %~1 %~2
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%~1', '%~2')"
    call:dk_checkError
goto:eof


::####################################################################
::# dk_makeDirectory(path)
::#
::#
:dk_makeDirectory () {
	call:dk_verbose "dk_makeDirectory(%*)"
	
    if NOT exist "%~1" mkdir "%~1"
goto:eof


::####################################################################
::# dk_validateBranch()
::#
::#
:dk_validateBranch () {
	call:dk_verbose "dk_validateBranch(%*)"
	
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH, default to Development
    for %%I in (.) do set FOLDER=%%~nxI

    set DKBRANCH=Development
    if exist .git (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 0 (
            set DKBRANCH=%FOLDER%
        )
    )

    call:dk_printVar DKBRANCH
    set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
    set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
    set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
    set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
    set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
    set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"

    :: make sure script is running from DKBRANCH_DIR
    ::if not %DKSCRIPT_DIR% == %DKBRANCH_DIR% (
    ::      if not exist %DKBRANCH_DIR%\%DKSCRIPT_NAME% (
    ::              copy %DKSCRIPT_DIR%\%DKSCRIPT_NAME% %DKBRANCH_DIR%\%DKSCRIPT_NAME%
    ::      )
    ::      echo .
    ::      echo "RELOADING SCRIPT TO -> %DKBRANCH_DIR%\%DKSCRIPT_NAME%"
    ::      pause
    ::      start "" "%DKBRANCH_DIR%\%DKSCRIPT_NAME%"
    ::      if exist %DKBRANCH_DIR%\%DKSCRIPT_NAME% (
    ::              del "%DKSCRIPT_DIR%\%DKSCRIPT_NAME%"
    ::      )
    ::      exit
    ::)
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateGit()
::#
::#
:dk_validateGit () {
	call:dk_verbose "dk_validateGit(%*)"
	
    if "%HOST_ARCH%"=="arm32" set GIT_DL=
    if "%HOST_ARCH%"=="arm64" set GIT_DL=%GIT_DL_WIN_ARM64%
    if "%HOST_ARCH%"=="x86" set GIT_DL=%GIT_DL_WIN_X86%
    if "%HOST_ARCH%"=="x86_64" set GIT_DL=%GIT_DL_WIN_X86_64%
        
    call:dk_getBasename %GIT_DL% GIT_DL_FILE
    ::call:dk_printVar GIT_DL_FILE

    set GIT_FOLDER=%GIT_DL_FILE:~0,-4%
    call:dk_convertToCIdentifier %GIT_FOLDER% GIT_FOLDER
    call:dk_toLower %GIT_FOLDER% GIT_FOLDER
    ::call:dk_printVar GIT_FOLDER

    set "GIT_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe"
    call:dk_printVar GIT_EXE
        
    if exist "%GIT_EXE%" goto:eof
        
    echo.   
    echo "Installing git . . ."
    call:dk_download %GIT_DL%
    ::echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR=%DKTOOLS_DIR%\%GIT_FOLDER%
    ::"%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR="%DKTOOLS_DIR%\%GIT_FOLDER%" /VERYSILENT
	echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
	   
    if NOT exist "%GIT_EXE%" (
        call:assert "cannot find git"
    )
        
    call:dk_checkError
goto:eof


::####################################################################
::# dk_extract(url, destination)
::#
::#
:dk_extract () {
	call:dk_verbose "dk_extract(%*)"
	
	echo Extracting %~1 to %2
	if not exist "%~1" (
        echo cannot find %~1
        goto:eof
    )
	::if exist "%~2" (
    ::    echo %~2 already exist
    ::    goto:eof
    ::)
    powershell Expand-Archive "%1" -DestinationPath "%2"
goto:eof


::####################################################################
::# dk_validateCmake()
::#
::#
:dk_validateCmake () {
	call:dk_verbose "dk_validateCmake(%*)"
	
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm32"    set "CMAKE_DL=%CMAKE_DL_WIN_ARM32%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"    set "CMAKE_DL=%CMAKE_DL_WIN_ARM64%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"      set "CMAKE_DL=%CMAKE_DL_WIN_X86%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   set "CMAKE_DL=%CMAKE_DL_WIN_X86_64%"
    if "%HOST_OS%"=="mac"                        set "CMAKE_DL=%CMAKE_DL_MAC%"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" set "CMAKE_DL=%CMAKE_DL_LINUX_X86_64%"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_arm64"  set "CMAKE_DL=%CMAKE_DL_LINUX_ARM64%"
    call:dk_printVar CMAKE_DL
    
    call:dk_getBasename %CMAKE_DL% CMAKE_DL_FILE
    call:dk_printVar CMAKE_DL_FILE
        
    set CMAKE_FOLDER=%CMAKE_DL_FILE:~0,-4%
    call:dk_convertToCIdentifier %CMAKE_FOLDER% CMAKE_FOLDER
    call:dk_toLower %CMAKE_FOLDER% CMAKE_FOLDER
    call:dk_printVar CMAKE_FOLDER
        
    set "CMAKE_EXE=%DKTOOLS_DIR%\%CMAKE_FOLDER%\bin\cmake.exe"
    call:dk_printVar CMAKE_EXE
        
    if exist "%CMAKE_EXE%" goto:eof
       
    echo.   
    echo "Installing cmake . . ."
    ::echo MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    ::MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    call:dk_download %CMAKE_DL%
	call:dk_extract "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" "%DKTOOLS_DIR%"
	set CMAKE_DL_NAME=%CMAKE_DL_FILE:~0,-4%
	rename "%DKTOOLS_DIR%\%CMAKE_DL_NAME%" "%CMAKE_FOLDER%"
	echo %CMAKE_FOLDER%>"%DKTOOLS_DIR%\%CMAKE_FOLDER%\installed"
    
    if NOT exist "%CMAKE_EXE%" (
        call:assert "cannot find cmake"
    )
        
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateVisualStudio()
::#
::#
:dk_validateVisualStudio () {
	call:dk_verbose "dk_validateVisualStudio(%*)"
	
    call:dk_cmakeEval "include('%DKIMPORTS_DIR%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateMsys2()
::#
::#
:dk_validateMsys2 () {
	call:dk_verbose "dk_validateMsys2(%*)"
	
    call:dk_cmakeEval "include('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateGcc()
::#
::#
:dk_validateGcc () {
	call:dk_verbose "dk_validateGcc(%*)"
	
    call:dk_cmakeEval "include('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateMake()
::#
::#
:dk_validateMake () {
	call:dk_verbose "dk_validateMake(%*)"
	
    call:dk_cmakeEval "include('%DKIMPORTS_DIR%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateOpenjdk()
::#
::#
:dk_validateOpenjdk () {
	call:dk_verbose "dk_validateOpenjdk(%*)"
	
    call:dk_cmakeEval "include('%DKIMPORTS_DIR%/openjdk/DKMAKE.cmake')" "OPENJDK"
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateAndroidNdk()
::#
::#
:dk_validateAndroidNdk () {
	call:dk_verbose "dk_validateAndroidNdk(%*)"
	
    call:dk_cmakeEval "include('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    call:dk_printVar ANDROID_GENERATOR
    call:dk_printVar ANDROID_API
    call:dk_printVar ANDROID_NDK
    call:dk_printVar ANDROID_TOOLCHAIN_FILE
    call:dk_checkError
goto:eof


::####################################################################
::# dk_validateEmscripten()
::#
::#
:dk_validateEmscripten () {
	call:dk_verbose "dk_validateEmscripten(%*)"
	
    call:dk_cmakeEval "include('%DKIMPORTS_DIR%/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
    call:dk_printVar EMSDK
    call:dk_printVar EMSDK_ENV
    call:dk_printVar EMSDK_GENERATOR
    call:dk_printVar EMSDK_TOOLCHAIN_FILE
    call:dk_printVar EMSDK_C_COMPILER
    call:dk_printVar EMSDK_CXX_COMPILER
    call:dk_checkError
goto:eof


::####################################################################
::# dk_commandToVariable(command, variable_name)
::#
::#
:dk_commandToVariable () {
	call:dk_verbose "dk_commandToVariable(%*)"
	
    if [%2] == [] (
        echo "ERROR: dk_commandToVariable() requires at least 2 parameters"
        goto:eof
    )
    set command=

    :command_args
    set arg=%1
    set arg=%arg:"=_QUOTE_%
        
    if not "%~2"=="" (
        if "%command%"=="" (
            set "command=%arg%"
        ) else (
            set "command=%command% %arg%"
        )
    )
    set variable_name=%~1
    shift
    if not "%~1"=="" goto command_args

    set command=%command:_QUOTE_="%

    for /F "tokens=*" %%g in ('%command% 2^> nul') do (
        set %variable_name%=%%g
        set "variable_value=%%g"
    )

    ::echo dk_commandToVariable(%*) -^> %%%variable_name%%% = %variable_value%
    call:dk_checkError
goto:eof



::####################################################################
::# dk_clearCmakeCache()
::#
::#
:dk_clearCmakeCache () {
	call:dk_verbose "dk_clearCmakeCache(%*)"
	
    ::call:dk_cmakeEval "dk_clearCmakeCache()"
    echo Deleteing CMake cache . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
    call:dk_checkError
goto:eof


::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles () {
	call:dk_verbose "dk_deleteTempFiles(%*)"
	
    ::call:dk_cmakeEval "dk_deleteTempFiles()"
    echo Deleteing .tmp files . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    call:dk_checkError
goto:eof


::################################################################################
::# dk_gitUpdate(NO_CONFIRM)
::#
::#
:dk_gitUpdate () {
	call:dk_verbose "dk_gitUpdate(%*)"
	
    if "%1" neq "NO_CONFIRM" (
        echo Git Update? Any local changes will be lost.
        set /P CONFIRM="Are you sure? [Y] " 
    )
    if /I "%CONFIRM%" neq "Y" goto:eof
        
    if NOT exist "%DKBRANCH_DIR%\.git" (
        "%GIT_EXE%" clone https://github.com/aquawicket/DigitalKnob.git "%DKBRANCH_DIR%"
    )
    call:dk_checkError

    cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" pull --all
    "%GIT_EXE%" checkout -- .
    call:dk_checkError

    "%GIT_EXE%" checkout %DKBRANCH%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %DKBRANCH% branch. Creating...
        "%GIT_EXE%" checkout -b %DKBRANCH% main
        "%GIT_EXE%" push --set-upstream origin %DKBRANCH%
    )

    call:dk_checkError
goto:eof


::################################################################################
::# dk_gitCommit()
::#
::#
:dk_gitCommit () {
	call:dk_verbose "dk_gitCommit(%*)"
	
    echo "Please enter some details about this commit, then press enter."
    set /p message=">" 
        
    cd %DKBRANCH_DIR%
        
    call:dk_commandToVariable "%GIT_EXE%" config --global credential.helper STORE
    if not "%STORE%"=="store" (
        "%GIT_EXE%" config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
    call:dk_commandToVariable "%GIT_EXE%" config --global user.email USER_EMAIL
    if "%USER_EMAIL%"=="" (
        echo.
        echo please enter an email address
        set /p input=">" 
        "%GIT_EXE%" config --global user.email "%input%"
        echo.
        echo "git user.email %input% saved"
        echo.
    )
        
    call:dk_commandToVariable "%GIT_EXE%" config --global user.email USER_NAME
    if "%USER_NAME%"=="" (
        echo.
        echo please enter a username
        set /p input=">" 
        "%GIT_EXE%" config --global user.name "%input%"
        echo.
        echo "git user.name %input% saved"
        echo.
    )
        
    if "%message%"=="" set "message=git commit"
        
    echo.
    echo git commit "%message%"
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" neq "Y" goto:eof
        
    "%GIT_EXE%" commit -a -m "%message%"
    "%GIT_EXE%" push
        
    call:dk_checkError
goto:eof


::################################################################################
::# dk_clearScreen()
::#
::#
:dk_clearScreen () {
	call:dk_verbose "dk_clearScreen(%*)"
	
    cls
goto:eof


::################################################################################
::# dk_cmakeEval(cmake_commands, return_variables, -DVARS,)
::#
::#
:dk_cmakeEval () {
	call:dk_verbose "dk_cmakeEval(%*)"
	
    echo.
    echo  $ dk_cmakeEval (%*)
    echo.
    
    if [%1] == [] (
        echo "ERROR: dk_cmakeEval() parameter1 is invalid"
        goto:eof
    )
    if not exist "%CMAKE_EXE%" ( 
        echo "ERROR: Could not locate CMAKE_EXE" 
        goto:eof
    )
    if not exist "%DKCMAKE_DIR%" ( 
        echo "ERROR: Could not locate DKCMAKE_DIR" 
        goto:eof
    )

    set commands=%1
    set variables=%2

    call set commands=%%commands:"=%%
    set "DKCOMMAND=%commands%"
    call set DKCOMMAND=%%DKCOMMAND:^\=^/%%
    ::#call:dk_printVar DKCOMMAND

    set "EVAL_VARS=%DKCMAKE_DIR%\cmake_vars.cmd"
    call set DKCMAKE_DIR=%%DKCMAKE_DIR:^\=^/%%
        
    ::echo "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/dev/cmake_eval.cmake" --log-level=TRACE >cmake_eval.out 2>cmake_eval.err

    if [%2] == [] goto no_return_values
    goto with_return_values

    :no_return_values
        "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/dev/cmake_eval.cmake"
    goto:eof

    :with_return_values
        "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" "-DDKRETURN=%~2" %~3 -P %DKCMAKE_DIR%/dev/cmake_eval.cmake
        if not exist %DKCMAKE_DIR%/cmake_vars.cmd goto:eof
        call %EVAL_VARS%
        ::del %EVAL_VARS%
    goto:eof

    ::call:dk_printVar ERRORLEVEL

    :::: work with cmake return code files ::::
    :: std::out
    set out=
    if exist "cmake_eval.out" (
        for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
            set out=!out!%%x
            echo %%x
        )
    )
    ::out contains all of the lines
    ::del cmake_eval.out
    ::echo %out%    

    :: std::err
    set err=
    if exist "cmake_eval.err" (
        for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
            set err=!err!%%x
            echo [91m %%x [0m
        )
    )
    ::del cmake_eval.out
    ::err contains all of the lines
    ::echo %err%

    call:dk_checkError
goto:eof


::################################################################################
::# dk_commandExists(command, result)
::#
::#
:dk_commandExists () {
	call:dk_verbose "dk_commandExists(%*)"
	
    set "command=%1"
    cmd /c "(help %command% > nul || exit 0) && where %command% > nul 2> nul"
    if %ERRORLEVEL% equ 0 echo "%command% found" & goto:eof
    echo "%command% NOT found"
goto:eof


::################################################################################
::# dk_stringContains(haystack, needle, result)
::#
::#
:dk_stringContains () {
	call:dk_verbose "dk_stringContains(%*)"
	
    call set "haystack=%1"
    call set "needle=%2"
    if not "x!haystack:%needle%=!"=="x%haystack%" set "%3=1"
    ::set "%3=0"
goto:eof


::################################################################################
::# dk_getBasename(path rtn_var)
::#
::#
:dk_getBasename () {
	call:dk_verbose "dk_getBasename(%*)"
	
    if [%1] == [] (
        echo "ERROR: dk_getBasename() parameter 1 is invalid"
        goto:eof
    )
    if [%2] == [] (
        echo "ERROR: dk_getBasename() parameter 2 is invalid"
        goto:eof
    )
    
    for %%F in ("%1") do (
        set %2=%%~nxF
        set val=%%~nxF
    )
    
    ::echo dk_getBasename(%*) -^> %2 = %val%
    call:dk_checkError
goto:eof


::################################################################################
::# dk_createCache()
::#
::#
:dk_createCache () {
	call:dk_verbose "dk_createCache(%*)"
	
    echo creating cache...
    ::call:dk_printVar APP
    ::call:dk_printVar TARGET_OS
    ::call:dk_printVar TYPE
    ::call:dk_printVar LEVEL
        
    :: https://stackoverflow.com/a/5143293/688352
    echo %APP%>"%DKBRANCH_DIR%\cache"
    echo %TARGET_OS%>>"%DKBRANCH_DIR%\cache"
    echo %TYPE%>>"%DKBRANCH_DIR%\cache"
    ::echo %LEVEL%>>"%DKBRANCH_DIR%\cache"
goto:eof


::################################################################################
::# dk_readCache()
::#
::#
:dk_readCache () {
	call:dk_verbose "dk_readCache(%*)"
	
    ::echo reading cache...
    if not exist %DKBRANCH_DIR%\cache goto:eof
    set /a count = 0
    for /f "tokens=*" %%a in (%DKBRANCH_DIR%\cache) do (
        set a=%%a: =%
        ::echo !count!: %%a
        if !count! == 0 set "_APP_=%%a"
        if !count! == 1 set "_TARGET_OS_=%%a"
        if !count! == 2 set "_TYPE_=%%a"
        if !count! == 3 set "_LEVEL_=%%a"
        call set /a count += 1
    )
        
    set _APP_=%_APP_: =%
    set _TARGET_OS_=%_TARGET_OS_: =%
    set _TYPE_=%_TYPE_: =%
    set _LEVEL_=%_LEVEL_: =%
goto:eof


::################################################################################
::# dk_convertToCIdentifier(in, out)
::#
::#
:dk_convertToCIdentifier () {
	call:dk_verbose "dk_convertToCIdentifier(%*)"
	
    set "_input=%1"
    set "_output="
    set "map=abcdefghijklmnopqrstuvwxyz 1234567890"

    :c_identifier_loop
        if not defined _input goto c_identifier_endLoop    
        for /F "delims=*~ eol=*" %%C in ("!_input:~0,1!") do (
                if "!map:%%C=!" neq "!map!" set "_output=!_output!%%C"
                if "!map:%%C=!" equ "!map!" set "_output=!_output!_"
        )
        set "_input=!_input:~1!"
    goto c_identifier_loop

    :c_identifier_endLoop
        set %2=!_output!
goto:eof


::################################################################################
::# dk_toLower(in, rtn_var)
::#
::#
:dk_toLower () {
	call:dk_verbose "dk_toLower(%*)"
	
    set _string=%1
    set "_UCASE=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    set "_LCASE=abcdefghijklmnopqrstuvwxyz"
    
    for /l %%a in (0,1,25) do (
        call set "_FROM=%%_UCASE:~%%a,1%%
        call set "_TO=%%_LCASE:~%%a,1%%
        call set "_string=%%_string:!_FROM!=!_TO!%%
    )
    ::call:dk_printVar _string
    set %2=%_string%
goto:eof


::################################################################################
::# dk_printVar(variable)
::#
::#
:dk_printVar () {
	::call:dk_verbose "dk_printVar(%*)"
	
    set "var=%1"
    call set "value=%%%var%%%"
	if "%value%" == "" echo %var%
    if "%value%" neq "" echo %var%: %value%
	
    ::echo %1 = !!!INVALID!!!
goto:eof


::################################################################################
::# dk_killProcess(name)
::#
::#
:dk_killProcess () {
	call:dk_verbose "dk_killProcess(%*)"
	
    taskkill /IM "%1" /F > nul
goto:eof


::################################################################################
::# dk_verbose(message)
::#
::#
:dk_verbose () {
	::call dk_verbose "dk_verbose(%*)"
	
	if %LOG_VERBOSE% == 1 ( 
		echo %cyan% VERBOSE: %1 %clr%
	)
goto:eof


::##################################################################################
::# dk_defined(variable)
::#
::# Evaluates to true if the parameter is a variable that exists.
::#
:dk_defined () {
	call:dk_verbose "dk_defined($*)"
::	[ $# -ne 1 ] && return $false # Incorrect number of parameters
	
::	eval value='$'{$1+x} # value will = 'x' if the variable is defined
::	[ -n "$value" ]

	if "%1"=="" echo "%1 is NOT defined"
	if NOT "%1"=="" echo "%1 IS defined"
goto:eof


::##################################################################################
::# dk_debug(msg)
::#
::#   Print a debug message to the console
::#
::#   @msg	- The message to print
::#
:dk_debug () {
	::call dk_verbose "dk_debug(%*)"
	
::	[ $# -lt 1 ] && dk_error "dk_debug($*): requires at least 1 parameter"
	
	if NOT %LOG_DEBUG% == 1 goto:eof
	
	set "msg=%1"
	
	::### print variable ###
	call set "value=%%%msg%%%"
    if "%value%" neq "" set "msg=%1 = '%value%'"
	if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	
	
	
	
	
	echo %blue%   DEBUG: %msg% %clr%
goto:eof

::################################################################################
::# dk_info(message)
::#
::#
:dk_info () {
	::call:dk_verbose "dk_info(%*)"
	
	echo %white%    INFO: %1 %clr%
goto:eof


::################################################################################
::# dk_warning(msg)
::#
::#	Print a warning message to the console
::#
::#	@msg	- The message to print
::#
:dk_warning () {
	::call dk_verbose "dk_warning(%*)"
	
	echo %yellow% WARNING: %1 %clr%
goto:eof


::#################################################################################
::# dk_error(msg)
::#
::#	Print a error message to the console
::#
::#	@msg	- The message to print
::#
:dk_error () {
	::call dk_verbose "dk_error(%*)"
	
	echo %red%   ERROR: %1 %clr%
	::dk_stacktrace
	::if [ $HALT_ON_ERRORS == 1 ]; then
	::	exit 1
	::fi
goto:eof

::################################################################################
::# dk_end()
::#
::#
:dk_end () {
	call:dk_verbose "dk_end(%*)"
	
    call:dk_error "reached the end of the script"
    pause
    exit
goto:eof
