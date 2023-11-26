# https://www.qemu.org
# https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe

# TODO


##### EAMPLE with tinycorelinux #####
# cd <iso directory>

### Create the virtual image (10gb)
# C:/Users/Administrator/digitalknob/DK/3rdParty/qemu-7.2.0/qemu-img create -f qcow2 tinycore.img 10G

### Launching the VM
# C:/Users/Administrator/digitalknob/DK/3rdParty/qemu-7.2.0/qemu-system-x86_64 -cdrom CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 2G -cpu max -smp 2 -vga virtio -display sdl

### Install the OS to the .img file
# (Install from the running virtual OS)

### Launching the VM without cdrom (after install)
# C:/Users/Administrator/digitalknob/DK/3rdParty/qemu-7.2.0/qemu-system-x86_64 -boot menu=on -drive file=tinycore.img -m 2G -cpu max -smp 2 -vga virtio -display sdl
