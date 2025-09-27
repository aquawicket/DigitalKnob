@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:: https://reactos.org
:: https://reactos.org/wiki/QEMU

::####################################################################
::# dk_installReactOS()
::#
:dk_installReactOS
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	set "reactos_Import=https://sourceforge.net/projects/reactos/files/ReactOS/0.4.14/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set reactos "%DKTOOLS_DIR%\ReactOS"
	%dk_call% dk_set reactos_Img %reactos%\reactos.img
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate qemu_img_exe "%dk_call% dk_depend qemu"
	
	%setlocal%
		if EXIST "%reactos_Img%" (%return%)
		
		%dk_call% dk_info "Installing ReactOS . . ."
		%dk_call% dk_basename %reactos_Import% reactos_Import_File
		%dk_call% dk_download %reactos_Import%
		%dk_call% dk_extract %dk_download%
		
		::###### create and cd into install directory ######
		%dk_call% dk_mkdir %reactos%
		%dk_call% dk_chdir %reactos%
		
		::###### Install the OS to the .img file ######
		::###### (Install from the running virtual OS) ######
		%dk_call% dk_info "########### ReactOS -install- ###############"
		%dk_call% dk_info " "
		%dk_call% dk_info ". Setup Instructions TODO here"
		
		::###### Create the virtual image (10gb) ######
		%qemu_img_exe% create -f qcow2 %reactos_Img% 10G

		::###### Launching the VM ######
		%qemu-system-x86_64_exe% -cdrom %DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso/ReactOS-0.4.14-release-119-gce0b4ff.iso -boot menu=on -drive file=%reactos_Img% -m 1G -cpu max -smp 2 -vga virtio -display sdl
		
		::###### create ReactOS Launcher ######
		%dk_call% dk_set REACTOS_launcher "%reactos%\LAUNCH.cmd"
		if EXIST "%REACTOS_launcher%" (%return%)
		%dk_call% dk_fileWrite "%REACTOS_launcher%" "start %qemu-system-x86_64_exe% -boot menu=on -drive file=%reactos_Img% -cpu max -smp 2 -vga virtio -display sdl"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_installReactOS
%endfunction%
