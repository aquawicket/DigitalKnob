
#exec &>1
#exec &>2
#exec &>3
#exec &>/dev/null

echo SendTo0 >&0
echo SendTo1 >&1      
echo SendTo2 >&2
#echo SendTo3 >&3
echo SentToFile >& File.txt



# https://en.wikipedia.org/wiki/Device_file
# https://tldp.org/LDP/sag/html/dev-fs.html

#echo SendTo_clipboard >&/dev/clipboard
#echo SendTo_console   >&/dev/console	# Console
#echo SendTo_dsp       >&/dev/dsp		# Digital Signal Processor
#echo SendTo_fd        >&/dev/fd
#echo SendTo_fd0       >&/dev/fb0		# Frame buffer device 0
#echo SendTo_fd0       >&/dev/fd0		# Floppy drive 0
#echo SendTo_full      >&/dev/full
#echo SendTo_hda       >&/dev/hda		# Master IDE drive
#echo SendTo_ht0       >&/dev/ht0		# IDE tape drive 0
#echo SendTo_js0       >&/dev/js0		# Joystick 0
#echo SendTo_loop0     >&/dev/loop0      # Loopback device 0
#echo SendTo_lp0       >&/dev/lp0        # Parallel printer 0
#echo SendTo_md0       >&/dev/md0        # Metadisk grou 0
#echo SendTo_mixer     >&/dev/mixer      # Open Sound System
#echo SendTo_mqueue    >&/dev/mqueue
#echo SendTo_null      >&/dev/null       # Null
#echo SendTo_parport0  >&/dev/parport0   # Raw parallel port 0 
#echo SendTo_pcd0      >&/dev/pcd0       # Parallel port CDROM 0
#echo SendTo_psaux     >&/dev/psaux      # PS/2 mouse
#echo SendTo_pt0       >&/dev/pt0        # Parallel port tape devices 0
#echo SendTo_ptmx      >&/dev/ptmx
#echo SendTo_pty0      >&/dev/pty0
#echo SendTo_pty1      >&/dev/pty1
#echo SendTo_random    >&/dev/random     # non-deterministic random number generator
#echo SendTo_scd0      >&/dev/scd0
#echo SendTo_sda       >&/dev/sda		# SCSI drive
#echo SendTo_sda1      >&/dev/sda1
#echo SendTo_sda2      >&/dev/sda2
#echo SendTo_sda3      >&/dev/sda3
#echo SendTo_sda4      >&/dev/sda4
#echo SendTo_shm       >&/dev/shm
#echo SendTo_sr0       >&/dev/sr0
#echo SendTo_stderr    >&/dev/stderr
#echo SendTo_stdin     >&/dev/stdin
#echo SendTo_stdout    >&/dev/stdout
#echo SendTo_tty       >&/dev/tty		# TeleTYpewriter
#echo SendTo_urandom   >&/dev/urandom	# fast random number generator
#echo SendTo_windows   >&/dev/windows
#echo SendTo_zero      >&/dev/zero       # 0


exec $SHELL