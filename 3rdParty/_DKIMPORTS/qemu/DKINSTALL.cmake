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


###################### qemu ######################
# https://www.qemu.org
# https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe
# https://azeria-labs.com/emulate-raspberry-pi-with-qemu	# Emulate Raspberry Pi
# https://qemu.weilnetz.de/w32/2022/qemu-w32-setup-20221230.exe
# https://qemu.weilnetz.de/w64/2025/qemu-w64-setup-20250806.exe

if(Windows_Host)
	dk_set	(qemu_Import https://qemu.weilnetz.de/w64/qemu-w64-setup-20240903.exe)
endif()
dk_assertVar(qemu_Import)

dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_importVariables(${qemu_Import} ROOT ${DKTOOLS_DIR})


#dk_set(qemu ${DKTOOLS_DIR}/${qemu_FOLDER})
dk_set(qemu-img_exe ${qemu}/qemu-img.exe)
dk_set(qemu-system-x86_64_exe ${qemu}/qemu-system-x86_64.exe)

### INSTALL ###
if(NOT EXISTS ${qemu-img_exe})
	dk_download(${qemu_Import})
	dk_pathToNative(${qemu} qemu_Native)
	dk_echo("Installing ${qemu_FOLDER} . . .")
	dk_set(command_string "${dk_download}" /S /D=${qemu_Native})
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
