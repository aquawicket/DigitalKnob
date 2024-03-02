# https://www.qemu.org
# https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe

# https://azeria-labs.com/emulate-raspberry-pi-with-qemu	# Emulate Raspberry Pi

WIN_HOST_dk_set	(QEUM_DL https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe)
dk_set			(QEUM ${DK3RDPARTY_DIR}/qeum)

### INSTALL ###
if(NOT EXISTS ${QEUM}/qemu-img.exe)
	dk_download(${QEUM_DL})
	get_filename_component(QEUM_DL_FILE ${QEUM_DL} NAME)

	file(TO_NATIVE_PATH ${QEUM} QEUM_INSTALL_PATH)
	set(command_string "${DKDOWNLOAD_DIR}/${QEUM_DL_FILE}" /D=${QEUM_INSTALL_PATH})

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
