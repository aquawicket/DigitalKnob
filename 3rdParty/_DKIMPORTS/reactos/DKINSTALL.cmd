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


rem ############ reactos ############
rem # https://reactos.org
rem # https://reactos.org/wiki/QEMU
rem # https://sourceforge.net/projects/reactos/files/ReactOS/0.4.14/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip
:DKINSTALL
rem %setlocal%
	
	set "reactos_Import=https://sourceforge.net/projects/reactos/files/ReactOS/0.4.14/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_set reactos "%DKTOOLS_DIR%\ReactOS"
	%dk_call% dk_set reactos_Img %reactos%\reactos.img
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate qemu_img_exe %dk_call% dk_depend qemu
	
	%setlocal%
		if EXIST "%reactos_Img%" (%return%)
		
		%dk_call% dk_info "Installing ReactOS . . ."
		%dk_call% dk_basename %reactos_Import% reactos_Import_File
		%dk_call% dk_download %reactos_Import%
		%dk_call% dk_extract %dk_download%
		
		rem ###### create and cd into install directory ######
		%dk_call% dk_mkdir %reactos%
		%dk_call% dk_chdir %reactos%
		
		rem ###### Install the OS to the .img file ######
		rem ###### (Install from the running virtual OS) ######
		%dk_call% dk_info "########### ReactOS -install- ###############"
		%dk_call% dk_info " "
		%dk_call% dk_info ". Setup Instructions TODO here"
		
		rem ###### Create the virtual image (10gb) ######
		%qemu_img_exe% create -f qcow2 %reactos_Img% 10G

		rem ###### Launching the VM ######
		%qemu-system-x86_64_exe% -cdrom %DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso/ReactOS-0.4.14-release-119-gce0b4ff.iso -boot menu=on -drive file=%reactos_Img% -m 1G -cpu max -smp 2 -vga virtio -display sdl
		
		rem ###### create ReactOS Launcher ######
		%dk_call% dk_set REACTOS_launcher "%reactos%\LAUNCH.cmd"
		if EXIST "%REACTOS_launcher%" (%return%)
		%dk_call% dk_fileWrite "%REACTOS_launcher%" "start %qemu-system-x86_64_exe% -boot menu=on -drive file=%reactos_Img% -cpu max -smp 2 -vga virtio -display sdl"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate reactos %dk_call% dk_depend reactos
%endfunction%
