#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ qemu ############
# https://www.qemu.org
# https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe
# https://azeria-labs.com/emulate-raspberry-pi-with-qemu	# Emulate Raspberry Pi

dk_validate(host_triple "dk_host_triple()")
WIN_HOST_dk_set	(QEMU_DL https://qemu.weilnetz.de/w64/qemu-w64-setup-20240903.exe)
dk_assertVar(QEMU_DL)
dk_importVariables(${QEMU_DL} rtn_var)

dk_validate(DKTOOLS_DIR "dk_DIGITALKNOB_DIR()")
dk_set(QEMU_DIR ${DKTOOLS_DIR}/${QEMU_FOLDER})
dk_set(QEMU_IMG_EXE ${QEMU_DIR}/qemu-img.exe)
dk_set(QEMU_SYSTEM_X86_64_EXE ${QEMU_DIR}/qemu-system-x86_64.exe)

### INSTALL ###
if(NOT EXISTS ${QEMU_IMG_EXE})
	dk_download(${QEMU_DL} ${DKDOWNLOAD_DIR})
	dk_getNativePath(${QEMU_DIR} QEMU_DIR_NATIVE)
	dk_set(command_string "${DKDOWNLOAD_DIR}/${QEMU_DL_FILE}" /D=${QEMU_DIR_NATIVE})
	dk_executeProcess(echo ${command_string})
	dk_executeProcess(${command_string})
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
