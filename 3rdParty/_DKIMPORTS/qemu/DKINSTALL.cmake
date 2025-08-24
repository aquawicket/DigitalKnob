#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ qemu ############
# https://www.qemu.org
# https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe
# https://azeria-labs.com/emulate-raspberry-pi-with-qemu	# Emulate Raspberry Pi

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Windows_Host)
	dk_set	(QEMU_DL https://qemu.weilnetz.de/w64/qemu-w64-setup-20240903.exe)
endif()
dk_assertVar(QEMU_DL)

dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_importVariables(${QEMU_DL} ROOT $ENV{DKTOOLS_DIR})


#dk_set(QEMU $ENV{DKTOOLS_DIR}/${QEMU_FOLDER})
dk_set(QEMU_IMG_EXE ${QEMU}/qemu-img.exe)
dk_set(QEMU_SYSTEM_X86_64_EXE ${QEMU}/qemu-system-x86_64.exe)

### INSTALL ###
if(NOT EXISTS ${QEMU_IMG_EXE})
	dk_download(${QEMU_DL} $ENV{DKDOWNLOAD_DIR})
	dk_nativePath(${QEMU} QEMU_NATIVE)
	dk_echo("Installing ${QEMU_FOLDER} . . .")
	dk_set(command_string "$ENV{DKDOWNLOAD_DIR}/${QEMU_IMPORT_FILE}" /S /D=${QEMU_NATIVE})
	dk_exec(echo ${command_string})
	dk_exec(${command_string})
endif()


##### EAMPLE with tinycorelinux #####
# cd <iso directory>

### Create the virtual image (10gb)
# C:/Users/Administrator/DigitalKnob/Development/3rdParty/qemu/qemu-img create -f qcow2 tinycore.img 10G

### Launching the VM
# C:/Users/Administrator/DigitalKnob/Development/3rdParty/qemu/qemu-system-x86_64 -cdrom CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl

### Install the OS to the .img file
# (Install from the running virtual OS)

### Launching the VM without cdrom (after install)
# cd <iso directory>
# C:/Users/Administrator/DigitalKnob/Development/3rdParty/qemu/qemu-system-x86_64 -boot menu=on -drive file=tinycore.img -cpu max -smp 2 -vga virtio -display sdl
