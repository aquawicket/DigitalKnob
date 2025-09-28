@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############ winpe ############
::# winpe_Import=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso"
::# winpe_Import=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuperLite50MB.iso"
::# winpe_Import=https://ia801808.us.archive.org/21/items/wpe-64/WPE64.iso"
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getUrl %winpe_Import%
	set "winpe_Import=%dk_getUrl%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set winpe_dir "%DKTOOLS_DIR%\WindowsPE"
	%dk_call% dk_set winpe_img "%winpe%\winpe.img"
	%dk_call% dk_set winpe_qcow "%winpe%\winpe.qcow"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate qemu_img_exe "%dk_call% dk_depend qemu"

::	if NOT EXIST "%winpe_qcow%" (%qemu_img_exe% convert -O qcow2 "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" "%winpe_qcow%")
::	%qemu-system-x86_64_exe% -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl
::	%return%
			
	::###### winpe_qcow ######
    if EXIST "%winpe_qcow%" (
		%dk_call% dk_info "%winpe_qcow% already exists"
		goto end_WIN_IMG
	)
		%dk_call% dk_info "Installing Windows PE . . ."
		%dk_call% dk_basename %WINPE_DL% WINPE_IMPORT_FILE
		%dk_call% dk_download "%WINPE_DL%"

		::###### create and cd into install directory ######
		if NOT EXIST "%winpe%" (%dk_call% dk_mkdir "%winpe%")
		%dk_call% dk_chdir "%winpe%"

		::###### Install the OS to the .img file ######
		:: (Install from the running virtual OS)
		:: %dk_call% dk_info "########### Windows PE -install- ###############"
		:: %dk_call% dk_info " "
		:: TODO

		::###### Create the virtual image (10gb) ######
		%qemu_img_exe% create -f qcow2 %winpe_qcow% 5G
		
		::###### Launching the VM ######
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%qemu-system-x86_64_exe% -cdrom "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl
			
		::%qemu-system-x86_64_exe% -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl
	:end_WIN_IMG
		
	::###### WINPE_launcher ######
	set "WINPE_launcher=%winpe%\LAUNCH.cmd"
	if EXIST "%WINPE_launcher%" (
		%dk_call% dk_info "%WINPE_launcher% already exists"
		%return%
	)
	::%dk_call% dk_fileWrite "%WINPE_launcher%" "start %qemu-system-x86_64_exe% -cdrom "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" -boot menu=on -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl"
	%dk_call% dk_fileWrite "%WINPE_launcher%" -cdrom "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" "start %qemu-system-x86_64_exe% -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl"
%endfunction%
	



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%