# dk_include_guard()

##################################################################################
# try(<args..>)
#
try() { 
	#$@ >/dev/null 2>&1
	$@ 2>&1
}

##################################################################################
# dk_get_host_triple(<input>)
#
#	Get host variable such as 'HOST_OS', 'HOST_ARCH', 'HOST_ENV', 'HOST_VENDOR
#	and build the accoring HOST_TRIPLE variable.  I.E. windows_x86_64_msys2
#
dk_get_host_triple () {
	dk_verbose "dk_get_host_triple($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	# currently, our host triple consists of only 2 variable needed
	# HOST_TRIPLE=${HOST_OS}_${HOST_ARCH}
	
	# https://unix.stackexchange.com/questions/225350/how-to-find-out-triplet-without-gcc
	# https://en.wikipedia.org/wiki/Uname
	
	# g++ -dumpmachine
	# gcc -print-multiarch
	# clang -print-effective-triple
	# clang -print-target-triple
	# clang++ -print-effective-triple
	# clang++ -print-target-triple

	#[ -e /proc/cpuinfo ] && dk_debug "\$(tr -d '\0' </proc/cpuinfo) = $(tr -d '\0' </proc/cpuinfo)"
	#[ -e /proc/device-tree/model ] && dk_debug "\$(tr -d '\0' </proc/device-tree/model) = $(tr -d '\0' </proc/device-tree/model)"

	if dk_command_exists clang; then  
		CLANG_TRIPLE=$(try clang -dumpmachine) && dk_debug CLANG_TRIPLE	

		remainder="$CLANG_TRIPLE"
		CLANG_ARCH="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug CLANG_ARCH
		CLANG_VENDOR="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug CLANG_VENDOR
		CLANG_OS="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug CLANG_OS
		CLANG_ENV="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug CLANG_ENV

		[ -z ${HOST_TRIPLE-} ] && HOST_TRIPLE=$CLANG_TRIPLE && dk_debug HOST_TRIPLE
		[ -z ${HOST_ARCH-} ] && HOST_ARCH=$CLANG_ARCH && dk_debug HOST_ARCH
		[ -z ${HOST_VENDOR-} ] && HOST_VENDOR=$CLANG_VENDOR && dk_debug HOST_VENDOR
		[ -z ${HOST_OS-} ] && HOST_OS=$CLANG_OS && dk_debug HOST_OS
		[ -z ${HOST_ENV-} ] && HOST_ENV=$CLANG_ENV && dk_debug HOST_ENV
	fi
	if dk_command_exists gcc; then
		GCC_TRIPLE=$(try gcc -dumpmachine) && dk_debug GCC_TRIPLE

		remainder="$GCC_TRIPLE"
		GCC_ARCH="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug GCC_ARCH
		GCC_VENDOR="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug GCC_VENDOR
		GCC_OS="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug GCC_OS
		GCC_ENV="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug GCC_ENV

		[ -z ${HOST_TRIPLE-} ] && HOST_TRIPLE=$GCC_TRIPLE && dk_debug HOST_TRIPLE
		[ -z ${HOST_ARCH-} ] && HOST_ARCH=$GCC_ARCH && dk_debug HOST_ARCH
		[ -z ${HOST_VENDOR-} ] && HOST_VENDOR=$GCC_VENDOR && dk_debug HOST_VENDOR
		[ -z ${HOST_OS-} ] && HOST_OS=$GCC_OS && dk_debug HOST_OS
		[ -z ${HOST_ENV-} ] && HOST_ENV=$GCC_ENV && dk_debug HOST_ENV
	fi
	if dk_command_exists bash; then
		BASH_TRIPLE=$(bash -c "echo \$MACHTYPE")
		dk_debug BASH_TRIPLE

		remainder="$BASH_TRIPLE"
		BASH_ARCH="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug BASH_ARCH
		BASH_VENDOR="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug BASH_VENDOR
		BASH_OS="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug BASH_OS
		BASH_ENV="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_debug BASH_ENV

		[ -z ${HOST_TRIPLE-} ] && HOST_TRIPLE=$BASH_TRIPLE && dk_debug HOST_TRIPLE
		[ -z ${HOST_ARCH-} ] && HOST_ARCH=$BASH_ARCH && dk_debug HOST_ARCH
		[ -z ${HOST_VENDOR-} ] && HOST_VENDOR=$BASH_VENDOR && dk_debug HOST_VENDOR
		[ -z ${HOST_OS-} ] && HOST_OS=$BASH_OS && dk_debug HOST_OS
		[ -z ${HOST_ENV-} ] && HOST_ENV=${BASH_ENV-} && dk_debug HOST_ENV
	fi	
	
	if dk_command_exists uname; then
		
		UNAME="$(uname)"
		dk_debug UNAME	
		UNAME_a="$(try uname -a)" && dk_debug UNAME_a
		UNAME_s="$(try uname -s)" && dk_debug UNAME_s
		UNAME_n="$(try uname -n)" && dk_debug UNAME_n	
		UNAME_r="$(try uname -r)" && dk_debug UNAME_r
		UNAME_v="$(try uname -v)" && dk_debug UNAME_v
		UNAME_m="$(try uname -m)" && dk_debug UNAME_m
		UNAME_p="$(try uname -p)" && dk_debug UNAME_p
		UNAME_i="$(try uname -i)" && dk_debug UNAME_i
		UNAME_o="$(try uname -o)" && dk_debug UNAME_o
		
		UNAME_ARCH="$(try uname -m)"
		dk_to_lower UNAME_ARCH
		UNAME_SUBARCH=""
		
		if [ "$(try uname -s)" = "Darwin" ]; then
			UNAME_VENDOR="-apple"
		else
			UNAME_VENDOR="-unknown"
		fi


		if [ "$(try uname -s)" = "darwin" ]; then
			UNAME_OS="-$(try uname -s)$(try uname -r)"
		else
			UNAME_OS="-$(try uname -s)" && dk_to_lower UNAME_OS
		fi

		if dk_string_contains "$(try uname -o)" "GNU"; then
			UNAME_ENV="-gnu"
		elif dk_string_contains "$(try uname -o)" "Android"; then
			UNAME_ENV="-android" #FIXME: need abi number I.E. -android24
		else
			UNAME_ENV=""
		fi

		#UNAME_ObjectFormat=""

		UNAME_TRIPLE=${UNAME_ARCH}${UNAME_SUBARCH}${UNAME_VENDOR}${UNAME_OS}${UNAME_ENV}
		dk_debug UNAME_TRIPLE

		[ -z $HOST_TRIPLE ] && HOST_TRIPLE=$UNAME_TRIPLE && dk_debug HOST_TRIPLE
		[ -z $HOST_ARCH ] && HOST_ARCH=$UNAME_ARCH && dk_debug HOST_ARCH
		[ -z $HOST_VENDOR ] && HOST_VENDOR=$UNAME_VENDOR && dk_debug HOST_VENDOR
		[ -z $HOST_OS ] && HOST_OS=$UNAME_OS && dk_debug HOST_OS
		[ -z $HOST_ENV ] && HOST_ENV=$UNAME_ENV && dk_debug HOST_ENV
	fi
	


	### Get the HOST_OS ###
	# https://llvm.org/doxygen/Triple_8h_source.html
	if dk_string_contains "${UNAME_a}" "Android"; then			# android
		HOST_OS="android"
	elif dk_string_contains "${UNAME_a}" "Darwin"; then			# mac
		HOST_OS="mac"
	elif dk_string_contains "${UNAME_a}" "raspberrypi"; then	# raspberry
		HOST_OS="raspberry"
 	elif dk_string_contains "${UNAME_a}" "Linux"; then			# linux
		HOST_OS="linux"
	elif dk_string_contains "${UNAME_a}" "Msys"; then			# win
		HOST_OS="win"
	else
		dk_error "Unsupported HOST_OS: ${UNAME_a}"
	fi
	[ -z "$HOST_OS" ] && dk_error "Failed to get HOST_OS variable"
	dk_debug HOST_OS


	### Get the HOST_ARCH ###
	# https://stackoverflow.com/a/45125525
	# aarch64    	- AArch64 (little endian)
    # aarch64_32 	- AArch64 (little endian ILP32)
    # aarch64_be 	- AArch64 (big endian)
	# alpha			-
    # amdgcn     	- AMD GCN GPUs
	# arc			-
    # arm        	- ARM
    # arm64      	- ARM64 (little endian)
    # arm64_32   	- ARM64 (little endian ILP32)
    # armeb      	- ARM (big endian)
	# armv7l	 	- 	
	# armv8b 	 	- (arm64 compat)
	# armv8l 	 	- (arm64 compat)
    # avr        	- Atmel AVR Microcontroller
	# blackfin		-
    # bpf        	- BPF (host endian)
    # bpfeb      	- BPF (big endian)
    # bpfel      	- BPF (little endian)
	# cris			- 
	# frv			-
	# h8300			-
    # hexagon    	- Hexagon
	# ia64			-
	# i386 		 	- (x86)
	# i686 		 	- (x86 compat)	
    # lanai      	- Lanai
	# m32r			-
    # m68k			- Motorola 68000 family
	# metag			-
	# microblaze	-
    # mips       	- MIPS (32-bit big endian)
    # mips64     	- MIPS (64-bit big endian)
    # mips64el   	- MIPS (64-bit little endian)
    # mipsel     	- MIPS (32-bit little endian)
	# mn10300		-
    # msp430     	- MSP430 [experimental]
	# nios2			-
    # nvptx      	- NVIDIA PTX 32-bit
    # nvptx64    	- NVIDIA PTX 64-bit
	# openrisc		- 
	# parisc 		- (native or compat)
	# parisc64 		- (parisc)
	# ppc 			- (powerpc native or compat)
    # ppc32      	- PowerPC 32
    # ppc32le    	- PowerPC 32 LE
    # ppc64      	- PowerPC 64
    # ppc64le    	- PowerPC 64 LE
	# ppcle 		- (powerpc native or compat)
    # r600       	- AMD GPUs HD2XXX-HD6XXX
    # riscv32    	- 32-bit RISC-V
    # riscv64    	- 64-bit RISC-V
	# s390 			- (s390x compat)
	# s390x			-
	# score			-
	# sh			-
	# sh64 (sh)		-
    # sparc      	- Sparc
	# sparc64		-
    # sparcel   	- Sparc LE
    # sparcv9   	- Sparc V9
    # systemz   	- SystemZ
    # thumb     	- Thumb
    # thumbeb   	- Thumb (big endian)
	# tile			-
	# unicore32		-
    # ve        	- VE
    # wasm32    	- WebAssembly 32-bit
    # wasm64    	- WebAssembly 64-bit
    # x86       	- 32-bit X86: Pentium-Pro and above
    # x86-64    	- 64-bit X86: EM64T and AMD64
    # xcore     	- XCore
	# xtensa		-
	
	if [ "$UNAME_m" = "arm" ]; then
		HOST_ARCH="arm"
	elif [ "$UNAME_m" = "armeb" ]; then
		HOST_ARCH="arm"
	elif [ "$UNAME_m" = "armv7l" ]; then
		HOST_ARCH="arm"
	elif [ "$UNAME_m" = "aarch64" ]; then
		HOST_ARCH="arm64"
	elif [ "$UNAME_m" = "aarch64_32" ]; then
		HOST_ARCH="arm64"
	elif [ "$UNAME_m" = "aarch64_be" ]; then
		HOST_ARCH="arm64"
	elif [ "$UNAME_m" = "arm64" ]; then
		HOST_ARCH="arm64"
	elif [ "$UNAME_m" = "arm64_32" ]; then
		HOST_ARCH="arm64"
	elif [ "$UNAME_m" = "armv8b" ]; then
		HOST_ARCH="arm64"
	elif [ "$UNAME_m" = "armv8l" ]; then
		HOST_ARCH="arm64"
	elif [ "$UNAME_m" = "x86" ]; then
		HOST_ARCH="x86"
	elif [ "$UNAME_m" = "i386" ]; then
		HOST_ARCH="x86"
	elif [ "$UNAME_m" = "i686" ]; then
		HOST_ARCH="x86"
	elif [ "$UNAME_m" = "x86_64" ]; then
		HOST_ARCH="x86_64"
	elif [ "$UNAME_m" = "x86-64" ]; then
		HOST_ARCH="x86_64"
	elif [ "$UNAME_m" = "ia64" ]; then
		HOST_ARCH="x86_64"
	else
		dk_error "Unsupported HOST_ARCH: ${UNAME_m}"
	fi

	HOST_TRIPLE=${HOST_OS}_${HOST_ARCH}
	dk_debug HOST_TRIPLE
	
	HOST_ENV=clang
    HOST_TRIPLE=${HOST_TRIPLE}_${HOST_ENV}
	dk_debug HOST_TRIPLE
}