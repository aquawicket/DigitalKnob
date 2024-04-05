::dk_include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_build_main()
::
::
:dk_build_main () {
	call dk_verbose "dk_build_main(%*)"
	:: call dk_validate_sudo
	
	::--------------------------------------------------------
    :: GLOBAL USER VARIABLES
    ::--------------------------------------------------------
    set SCRIPT_DIR=%~dp0
    set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%
    call dk_print_var SCRIPT_DIR
    set SCRIPT_NAME=%~nx0
    call dk_print_var SCRIPT_NAME
    echo %SCRIPT_DIR%\%SCRIPT_NAME%

    set "CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip"
    set "CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip"
    set "CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip"
    set "CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz"
    set "CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz"
    set "CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz"
    set "CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz"

	set GIT_DL_WIN_X86=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe
	set GIT_DL_WIN_X86_64=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe

	call dk_get_dkpaths
    
    set NATIVE_OS=win
    call dk_print_var NATIVE_OS
        
    if %PROCESSOR_ARCHITECTURE%==x86 set NATIVE_ARCH=x86
    if %PROCESSOR_ARCHITECTURE%==AMD64 set NATIVE_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==IA64  set NATIVE_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==EM64T set NATIVE_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==ARM64  set NATIVE_ARCH=arm64
    call dk_print_var NATIVE_ARCH
        
    set NATIVE_TRIPLE=%NATIVE_OS%_%NATIVE_ARCH%
    call dk_print_var NATIVE_TRIPLE
    
    set NATIVE_ENV=clang
    set NATIVE_TRIPLE=%NATIVE_TRIPLE%_%NATIVE_ENV%

    call dk_validate_git
    call dk_validate_branch

    call dk_print_var DKBRANCH_DIR
    call dk_print_var DKAPPS_DIR
    call dk_print_var DKCMAKE_DIR
    call dk_print_var DK3RDPARTY_DIR
    call dk_print_var DKIMPORTS_DIR
    call dk_print_var DKPLUGINS_DIR
        
    call dk_validate_cmake
    
    :while_loop             
		if "%UPDATE%"==""     call dk_pick_update & goto:while_loop
		if "%APP%"==""        call dk_pick_app    & goto:while_loop
		if "%TARGET_OS%"==""  call dk_pick_os     & goto:while_loop
		if "%TYPE%"==""       call dk_pick_type   & goto:while_loop

		call dk_create_cache
		
		call dk_generate
		if %TARGET_OS%==android_arm32      call dk_generate_toolchain android_arm32_toolchain
		if %TARGET_OS%==android_arm64      call dk_generate_toolchain android_arm64_toolchain
		if %TARGET_OS%==emscripten         call dk_generate_toolchain emscripten_toolchain
		if %TARGET_OS%==win_arm64_clang    call dk_generate_toolchain windows_arm64_clang_toolchain
		if %TARGET_OS%==win_x86_mingw      call dk_generate_toolchain windows_x86_mingw_toolchain
		if %TARGET_OS%==win_x86_clang      call dk_generate_toolchain windows_x86_clang_toolchain
		if %TARGET_OS%==win_x86_msvc       call dk_generate_toolchain windows_x86_msvc_toolchain
		if %TARGET_OS%==win_x86_64_mingw   call dk_generate_toolchain windows_x86_64_mingw_toolchain
		if %TARGET_OS%==win_x86_64_clang   call dk_generate_toolchain windows_x86_64_clang_toolchain
		if %TARGET_OS%==win_x86_64_ucrt    call dk_generate_toolchain windows_x86_64_ucrt_toolchain
		if %TARGET_OS%==win_x86_64_msvc    call dk_generate_toolchain windows_x86_64_msvc_toolchain
		
		call dk_build
		if %TYPE%==All      call dk_build_all
		if %TYPE%==Release  call dk_build_release
		if %TYPE%==Debug    call dk_build_debug
		call dk_end_message
		
		:: TODO
		call dk_post_build_menu
    goto while_loop
    :while_loop_end
goto:eof