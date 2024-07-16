#!/bin/sh

###### Load Function files ######
. ../../../DKBash/functions/DK.sh

# to run this script requires privledges
# > chmod 777 build


# Install instructions ::
# select Frugal
# select sda
# check online

# delete tinycore.img to redo the process if needed

TINYCORELINUX_DL="http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso"
TINYCORELINUX_ISO="CorePlus-current.iso"
TINYCORELINUX_IMG="tinycore.img"
QEMU="/usr/bin"
QEMU_MEMORY="1G"
QEMU_DRIVE_SIZE="10G"


# Launching the VM (after install)
function launch() {
	echo "Starting up TinyCoreLinux . . ."
	${QEMU}/qemu-system-x86_64 -boot menu=on -drive file=${TINYCORELINUX_IMG} -m ${QEMU_MEMORY} -cpu max -smp 2 -vga virtio
}

# Launching the VM with CD to install
function install() {
	echo "Installing TinyCoreLinux . . ."
	${QEMU}/qemu-system-x86_64 -cdrom ${TINYCORELINUX_ISO} -boot menu=on -drive file=${TINYCORELINUX_IMG} -m ${QEMU_MEMORY} -cpu max -smp 2 -vga virtio
	#if NOT "%ERRORLEVEL%" == "0" (
	#	del %TINYCORELINUX_IMG%
	#	assert "Launching the virtual maching failed"
	#)
	echo "Installation complete"
}

# Create the virtual image (10gb)
function create_image() {
	if file_exists ${TINYCORELINUX_IMG%}; then
		assert "${TINYCORELINUX_IMG} already exists"
		return 1
	fi
	echo "Creating ${TINYCORELINUX_IMG} . . ."
	${QEMU}/qemu-img create -f qcow2 ${TINYCORELINUX_IMG} ${QEMU_DRIVE_SIZE}
	
	#if NOT "%ERRORLEVEL%" == "0" (
	#	del %TINYCORELINUX_IMG%
	#	assert "Failed to create image"
	#)

	install
}

# Download CorePlus-current.iso
function download_iso() {
	if ! file_exists ${TINYCORELINUX_ISO}; then
		echo "Downloading CorePlus-current.iso . . ."
		download ${TINYCORELINUX_DL} ${TINYCORELINUX_ISO}
	fi
	create_image
}

### main ###
function main() {
	echo "TinyCoreLinux"

	if file_exists ${TINYCORELINUX_IMG}; then
		launch
	else
		download_iso
	fi
}
main
dk_pause	
