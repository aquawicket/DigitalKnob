# https://www.qemu.org
# https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe

# https://azeria-labs.com/emulate-raspberry-pi-with-qemu	# Emulate Raspberry Pi
if(NOT HOST)
	dk_getHostTriple()
endif()

WIN_HOST_dk_set	(QEMU_DL https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe)

if(NOT DKTOOLS_DIR)
	dk_getDKPaths()
endif()
	
## Get QEMU_DL_FILE, QEMU_FOLDER

if(QEMU_DL)
	get_filename_component(QEMU_DL_FILE ${QEMU_DL} NAME)
	dk_removeExtension(${QEMU_DL_FILE} QEMU_FOLDER)
	string(MAKE_C_IDENTIFIER ${QEMU_FOLDER} QEMU_FOLDER)
	dk_set(QEMU ${DKTOOLS_DIR}/${QEMU_FOLDER})
	dk_set(QEMU_IMG_EXE ${QEMU}/qemu-img.exe)
	dk_set(QEMU_SYSTEM_X86_64_EXE ${QEMU}/qemu-system-x86_64.exe)
endif()


### INSTALL ###
if(NOT EXISTS ${QEMU_IMG_EXE})
	dk_download(${QEMU_DL} ${DKDOWNLOAD_DIR})

	file(TO_NATIVE_PATH ${QEMU} QEMU_INSTALL_PATH)
	set(command_string "${DKDOWNLOAD_DIR}/${QEMU_DL_FILE}" /D=${QEMU_INSTALL_PATH})

	execute_process(COMMAND cmd /c echo ${command_string})
	execute_process(COMMAND cmd /c ${command_string})
endif()


##### EAMPLE with tinycorelinux #####
# cd <iso directory>

### Create the virtual image (10gb)
# C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-img create -f qcow2 tinycore.img 10G

### Launching the VM
# C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-system-x86_64 -cdrom CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl

### Install the OS to the .img file
# (Install from the running virtual OS)

### Launching the VM without cdrom (after install)
# cd <iso directory>
# C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-system-x86_64 -boot menu=on -drive file=tinycore.img -cpu max -smp 2 -vga virtio -display sdl
