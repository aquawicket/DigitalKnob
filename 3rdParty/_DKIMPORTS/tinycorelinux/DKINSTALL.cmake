#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ tinycorelinux ############
# http://tinycorelinux.net/downloads.html
# http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso

dk_depend(qemu)

dk_import()

if(NOT EXISTS ${tinycorelinux}/tinycore.img)
	dk_info("Installing tiny-core-linux . . .")

	##### EAMPLE with tinycorelinux #####
	dk_chdir(${tinycorelinux})

	### Install the OS to the .img file
	# (Install from the running virtual OS)
	dk_info("########### Tiny Core Linux -install- ###############")
	dk_info(" ")
	dk_info(". Choose:  Boot Core with X/GUI (TinyCore) - Installation Extension")
	dk_info(". Click Tc-install icon to install   (bottom right)")
	dk_info(". Check Frugal, Whole Disc, sda1,  install bootloader, and click next")
	dk_info(". ext4 and click next")
	dk_info(". choose any advanced options if needed.  (next)")
	dk_info(". check Core and X/GUI Desktop.  check wifi and all the other boxes as well (next)")
	dk_info(". Give the install process a moment to format and install..")
	dk_info(" ")
	dk_info(". When instal finishes, shut down.")
	dk_info(". A LAUNCH shortcut will be created the int DKTools/TinyCoreLinux directory")

	### Create the virtual image (10gb)
	# C:/Users/Administrator/DigitalKnob/Development/3rdParty/qemu/qemu-img create -f qcow2 tinycore.img 10G
	dk_exec(${qemu_img_exe} create -f qcow2 tinycore.img 10G)

	### Launching the VM
	# C:/Users/Administrator/DigitalKnob/Development/3rdParty/qemu/qemu-system-x86_64 -cdrom CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl
	dk_exec(${qemu-system-x86_64_exe} -cdrom ${DKDOWNLOAD_DIR}/CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl)
endif()

dk_set(tinycourlinux_launcher "${tinycorelinux}/LAUNCH.cmd")
### Create Launcher shortcut
# Create launcher
### Launching the VM without cdrom (after install)
# cd into install directory
# C:/Users/Administrator/DigitalKnob/Development/3rdParty/qemu/qemu-system-x86_64 -boot menu=on -drive file=tinycore.img -cpu max -smp 2 -vga virtio -display sdl
	
	
if(NOT EXISTS 	"${tinycourlinux_launcher}")
	dk_fileWrite("${tinycourlinux_launcher}" "@echo off && start ${qemu-system-x86_64_exe} -boot menu=on -drive file=tinycore.img -cpu max -smp 2 -vga virtio -display sdl")
endif()
