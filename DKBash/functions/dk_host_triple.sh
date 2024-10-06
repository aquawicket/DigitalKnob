#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# try(<args..>)
#
try() { 
	#${@} &>/dev/null
	${@} 2>&1
}

##################################################################################
# dk_host_triple()
#
#	Get host variable such as 'host_arch', 'host_vendor', 'host_os', 'host_env'
#	and build the accoring host_triple variable.  I.E. x86_64_windows_msys2
#
#   TRIPLE:
#   architecture	The target’s architecture. If none is specified, an unknown architecture is assumed.
#   sub          	The target’s sub architecture
#	vendor			The target’s vendor. If none is specified, an unknown vendor is assumed.
#	os				The target’s operating system. If none is specified, an unknown operating system is assumed.
# 	environment     The target’s environment. If none is specified, an unknown environment is assumed.
#	objectFormat	The target’s object file format. If none is specified, an unknown object file format is assumed.
#
#	ARCHITECTURE   -   VENDOR   -   OS   -   ENVIRONMENT
#	<arch><sub>       <vendor>     <os>      <env><format>
#
#	<arch>    = arm, arm64, x86, x86_64, wasm32, wasm64
#    <sub>    = i.e on ARM: v5, v6m, v7a, v7m, etc.
#   <vendor>  = pc, apple
#   <os>      = darwin, emscripten, ios, linux, macosx, win32, wasi
#   <env>     = gnu, android, musl, msvc, simulator
#    <format> = coff, elf, wasm
#
#
#   HOST TRIPLES:
#   i686-w64-mingw32
#   x86_64-alpine-linux-musl
#   x86_64-pc-msys
#   x86_64-pc-windows-msvc
#   x86_64-unknown-mingw64_nt-1
#   x86_64-unknown-msys_nt-10.0-19041
#   x86_64-unknown-mingw64_nt-10.0-19041'
#   x86_64-w64-windows-gnu
#
#
#   REFERENCE: http://wiki.osdev.org/Target_Triplet
#              https://wiki.debian.org/Multiarch/Tuples
#              https://clang.llvm.org/docs/CrossCompilation.html
#              https://llvm.org/doxygen/Triple_8h_source.html
#              https://doc.rust-lang.org/rustc/platform-support.html
#              https://llvm-swift.github.io/LLVMSwift/Structs/Triple.html
#              https://stackoverflow.com/questions/47010422/cross-compilation-terminologies-build-host-and-target
#
dk_host_triple() {
	dk_debugFunc 0

	# currently, our host triple consists of only 2 variable needed
	# host_triple=${host_os}_${host_arch}
	
	# https://unix.stackexchange.com/questions/225350/how-to-find-out-triplet-without-gcc
	# https://en.wikipedia.org/wiki/Uname
	
	# g++ -dumpmachine
	# gcc -print-multiarch
	# clang -print-effective-triple
	# clang -print-target-triple
	# clang++ -print-effective-triple
	# clang++ -print-target-triple

	#[ -e /proc/cpuinfo ] && dk_call dk_debug "\$(tr -d '\0' </proc/cpuinfo) = $(tr -d '\0' </proc/cpuinfo)"
	#[ -e /proc/device-tree/model ] && dk_call dk_debug "\$(tr -d '\0' </proc/device-tree/model) = $(tr -d '\0' </proc/device-tree/model)"

	if dk_call dk_commandExists clang; then  
		clang_triple=$(try clang -dumpmachine) && dk_call dk_printVar clang_triple	

		remainder="${clang_triple}"
		clang_arch="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar clang_arch
		clang_vendor="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar clang_vendor
		clang_os="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar clang_os
		clang_env="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar clang_env

		[ -z ${host_triple-} ] && host_triple=${clang_triple} && dk_call dk_printVar host_triple
		[ -z ${host_arch-} ]   && host_arch=${clang_arch}     && dk_call dk_printVar host_arch
		[ -z ${host_vendor-} ] && host_vendor=${clang_vendor} && dk_call dk_printVar host_vendor
		[ -z ${host_os-} ]     && host_os=${clang_os}         && dk_call dk_printVar host_os
		[ -z ${host_env-} ]    && host_env=${clang_env}       && dk_call dk_printVar host_env
	fi
	if dk_call dk_commandExists gcc; then
		gcc_triple=$(try gcc -dumpmachine) && dk_call dk_printVar gcc_triple

		remainder="${gcc_triple}"
		gcc_arch="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar gcc_arch
		
		gcc_vendor="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar gcc_vendor
		
		gcc_os="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar gcc_os
		
		gcc_env="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar gcc_env

		[ -z ${host_triple-} ] && host_triple=${gcc_triple} && dk_call dk_printVar host_triple
		[ -z ${host_arch-} ]   && host_arch=${gcc_arch}     && dk_call dk_printVar host_arch
		[ -z ${host_vendor-} ] && host_vendor=${gcc_vendor} && dk_call dk_printVar host_vendor
		[ -z ${host_os-} ]     && host_os=${gcc_os}         && dk_call dk_printVar host_os
		[ -z ${host_env-} ]    && host_env=${gcc_env}       && dk_call dk_printVar host_env
	fi
	if dk_call dk_commandExists bash; then
		bash_triple=$(bash -c "builtin echo \${MACHTYPE}")
		dk_call dk_printVar bash_triple

		remainder="${bash_triple}"
		bash_arch="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar bash_arch
		
		bash_vendor="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar bash_vendor
		
		bash_os="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar bash_os
		
		bash_env="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_call dk_printVar bash_env

		[ -z ${host_triple-} ] && host_triple=${bash_triple} && dk_call dk_printVar host_triple
		[ -z ${host_arch-} ]   && host_arch=${bash_arch}     && dk_call dk_printVar host_arch
		[ -z ${host_vendor-} ] && host_vendor=${bash_vendor} && dk_call dk_printVar host_vendor
		[ -z ${host_os-} ]     && host_os=${bash_os}         && dk_call dk_printVar host_os
		[ -z ${host_env-} ]    && host_env=${bash_env}       && dk_call dk_printVar host_env
	fi	
	
	if dk_call dk_commandExists uname; then
		
		UNAME="$(uname)"             && dk_call dk_printVar UNAME
		UNAME_a="$(try uname -a)"    && dk_call dk_printVar UNAME_a
		UNAME_s="$(try uname -s)"    && dk_call dk_printVar UNAME_s
		UNAME_n="$(try uname -n)"    && dk_call dk_printVar UNAME_n	
		UNAME_r="$(try uname -r)"    && dk_call dk_printVar UNAME_r
		UNAME_v="$(try uname -v)"    && dk_call dk_printVar UNAME_v
		UNAME_m="$(try uname -m)"    && dk_call dk_printVar UNAME_m
		UNAME_p="$(try uname -p)"    && dk_call dk_printVar UNAME_p
		UNAME_i="$(try uname -i)"    && dk_call dk_printVar UNAME_i
		UNAME_o="$(try uname -o)"    && dk_call dk_printVar UNAME_o
		UNAME_ARCH="$(try uname -m)" && dk_call dk_printVar UNAME_ARCH
		
		dk_call dk_toLower "${UNAME_ARCH}" UNAME_ARCH
		UNAME_SUBARCH=""
		
		if [ "$(try uname -s)" = "Darwin" ]; then
			UNAME_VENDOR="-apple"
		else
			UNAME_VENDOR="-unknown"
		fi
		
		if [ "$(try uname -s)" = "darwin" ]; then
			UNAME_OS="-$(try uname -s)$(try uname -r)"
		else
			UNAME_OS="-$(try uname -s)" && dk_call dk_toLower "${UNAME_OS}" UNAME_OS
		fi

		if dk_call dk_stringContains "$(try uname -o)" "GNU"; then
			UNAME_ENV="-gnu"
		elif dk_call dk_stringContains "$(try uname -o)" "Android"; then
			UNAME_ENV="-android" #FIXME: need abi number I.E. -android24
		else
			UNAME_ENV=""
		fi

		#UNAME_ObjectFormat=""

		UNAME_TRIPLE=${UNAME_ARCH}${UNAME_SUBARCH}${UNAME_VENDOR}${UNAME_OS}${UNAME_ENV}
		dk_call dk_printVar UNAME_TRIPLE

		[ -z ${host_triple} ] && host_triple=${UNAME_TRIPLE} && dk_call dk_printVar host_triple
		[ -z ${host_arch} ]   && host_arch=${UNAME_ARCH}     && dk_call dk_printVar host_arch
		[ -z ${host_vendor} ] && host_vendor=${UNAME_VENDOR} && dk_call dk_printVar host_vendor
		[ -z ${host_os} ]     && host_os=${UNAME_OS}         && dk_call dk_printVar host_os
		[ -z ${host_env} ]    && host_env=${UNAME_ENV}       && dk_call dk_printVar host_env
	fi
	
	
	
	
	
	
	
	
	###### host_os and <os>_host ######
	# https://llvm.org/doxygen/Triple_8h_source.html
	if dk_call dk_stringContains "${UNAME_a}" "Android"; then			# android
		export host_os="android"
	elif dk_call dk_stringContains "${UNAME_a}" "Darwin"; then			# mac
		export host_os="mac"
	elif dk_call dk_stringContains "${UNAME_a}" "raspberrypi"; then	# raspberry
		export host_os="raspberry"
 	elif dk_call dk_stringContains "${UNAME_a}" "Linux"; then			# linux
		export host_os="linux"
	elif dk_call dk_stringContains "${UNAME_a}" "Msys"; then			# win
		export host_os="win"
	else
		dk_call dk_error "Unsupported host_os: ${UNAME_a}"
	fi
	[ -z "$host_os" ] && dk_call dk_error "Failed to get host_os variable"
	dk_call dk_printVar host_os


	###### host_arch and <arch>_host ######
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
	
	if [ "${UNAME_m}" = "arm" ]; then
		export host_arch="arm"
	elif [ "${UNAME_m}" = "armeb" ]; then
		export host_arch="arm"
	elif [ "${UNAME_m}" = "armv7l" ]; then
		export host_arch="arm"
	elif [ "${UNAME_m}" = "aarch64" ]; then
		export host_arch="arm64"
	elif [ "${UNAME_m}" = "aarch64_32" ]; then
		export host_arch="arm64"
	elif [ "${UNAME_m}" = "aarch64_be" ]; then
		export host_arch="arm64"
	elif [ "${UNAME_m}" = "arm64" ]; then
		export host_arch="arm64"
	elif [ "${UNAME_m}" = "arm64_32" ]; then
		export host_arch="arm64"
	elif [ "${UNAME_m}" = "armv8b" ]; then
		export host_arch="arm64"
	elif [ "${UNAME_m}" = "armv8l" ]; then
		export host_arch="arm64"
	elif [ "${UNAME_m}" = "x86" ]; then
		export host_arch="x86"
	elif [ "${UNAME_m}" = "i386" ]; then
		export host_arch="x86"
	elif [ "${UNAME_m}" = "i686" ]; then
		export host_arch="x86"
	elif [ "${UNAME_m}" = "x86_64" ]; then
		export host_arch="x86_64"
	elif [ "${UNAME_m}" = "x86-64" ]; then
		export host_arch="x86_64"
	elif [ "${UNAME_m}" = "ia64" ]; then
		export host_arch="x86_64"
	else
		dk_call dk_error "Unsupported host_arch: ${UNAME_m}"
	fi

	###### host_triple and <triple>_host ######
	export host_triple=${host_os}_${host_arch}
	dk_call dk_printVar host_triple
	
	###### host_env and <env>_host ######
	if [ "${host_os}" = "win" ]; then
		export host_env=clang
		export host_triple=${host_triple}_${host_env}
		#export host_triple=${host_arch}-${host_vendor}-${host_os}
		dk_call dk_printVar host_triple
	fi
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_host_triple
	dk_call dk_info "host_triple = ${host_triple}"
}
