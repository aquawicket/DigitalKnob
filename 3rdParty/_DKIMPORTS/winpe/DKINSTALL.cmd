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


::############ winpe ############
::# winpe_Import=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso"
::# winpe_Import=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuperLite50MB.iso"
::# winpe_Import=https://ia801808.us.archive.org/21/items/wpe-64/WPE64.iso"
::#
:DKINSTALL
::%setlocal%
	
	::%dk_call% dk_getUrl %winpe_Import%
	::set "winpe_Import=%dk_getUrl%"
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_set winpe_dir "%DKTOOLS_DIR%\WindowsPE"
	%dk_call% dk_set winpe_img "%winpe%\winpe.img"
	%dk_call% dk_set winpe_qcow "%winpe%\winpe.qcow"
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate qemu_img_exe %dk_call% dk_depend qemu

::	if NOT EXIST "%winpe_qcow%" (%qemu_img_exe% convert -O qcow2 "%DKDOWNLOAD_DIR%/%winpe_Import_FILE%" "%winpe_qcow%")
::	%qemu-system-x86_64_exe% -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl
::	%return%
			
	::###### winpe_qcow ######
    if EXIST "%winpe_qcow%" (
		%dk_call% dk_info "%winpe_qcow% already exists"
		goto end_WIN_IMG
	)
	
	%dk_call% dk_info "Installing Windows PE . . ."
	%dk_call% dk_download "%winpe_Import%"

	::###### create and cd into install directory ######
	%dk_call% dk_mkdir "%winpe%"
	%dk_call% dk_chdir "%winpe%"

	::###### Install the OS to the .img file ######
	:: (Install from the running virtual OS)
	:: %dk_call% dk_info "########### Windows PE -install- ###############"
	:: %dk_call% dk_info " "
	:: TODO

	::###### Create the virtual image (10gb) ######
	%qemu_img_exe% create -f qcow2 %winpe_qcow% 5G
		
		::###### Launching the VM ######
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%qemu-system-x86_64_exe% -cdrom "%winpe_Import%" -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl
			
	::%qemu-system-x86_64_exe% -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl
	:end_WIN_IMG
		
	::###### winpe_launcher ######
	set "winpe_Launcher=%winpe%\LAUNCH.cmd"
	if EXIST "%winpe_Launcher%" (
		%dk_call% dk_info "%winpe_Launcher% already exists"
		%return%
	)
	::%dk_call% dk_fileWrite "%winpe_Launcher%" "start %qemu-system-x86_64_exe% -cdrom "%DKDOWNLOAD_DIR%/%winpe_Import_FILE%" -boot menu=on -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl"
	%dk_call% dk_fileWrite "%winpe_Launcher%" -cdrom "%DKDOWNLOAD_DIR%/%winpe_Import_FILE%" "start %qemu-system-x86_64_exe% -drive file=%winpe_qcow% -m 1G -cpu max -smp 2 -vga virtio -display sdl"
%endfunction%
	



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKINSTALL
%endfunction%