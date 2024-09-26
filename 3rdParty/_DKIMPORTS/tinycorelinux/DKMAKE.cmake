include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# http://tinycorelinux.net/downloads.html
# http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso

dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()") 

dk_depend(qemu)

dk_set(TINYCORELINUX_DL http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso)
dk_set(TINYCORELINUX ${DKTOOLS_DIR}/TinyCoreLinux)

if(NOT EXISTS ${TINYCORELINUX}/tinycore.img)
	dk_info("Installing tiny-core-linux . . .")
	
	dk_basename(${TINYCORELINUX_DL} TINYCORELINUX_DL_FILE)
	dk_download(${TINYCORELINUX_DL} ${DKDOWNLOAD_DIR}/${TINYCORELINUX_DL_FILE})

	##### EAMPLE with tinycorelinux #####
	# cd into install directory
	dk_cd(${TINYCORELINUX})

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
	# C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-img create -f qcow2 tinycore.img 10G
	dk_command(${QEMU_IMG_EXE} create -f qcow2 tinycore.img 10G)

	### Launching the VM
	# C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-system-x86_64 -cdrom CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl
	dk_command(${QEMU_SYSTEM_X86_64_EXE} -cdrom ${DKDOWNLOAD_DIR}/CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl)
endif()

dk_set(TINYCOURLINUX_launcher "${TINYCORELINUX}/LAUNCH.cmd")
### Create Launcher shortcut
# Create launcher
### Launching the VM without cdrom (after install)
# cd into install directory
# C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-system-x86_64 -boot menu=on -drive file=tinycore.img -cpu max -smp 2 -vga virtio -display sdl
	
	
if(NOT EXISTS 	"${TINYCOURLINUX_launcher}")
	dk_fileWrite("${TINYCOURLINUX_launcher}" "@echo off && start ${QEMU_SYSTEM_X86_64_EXE} -boot menu=on -drive file=tinycore.img -cpu max -smp 2 -vga virtio -display sdl")
endif()
