#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


#####################################################################
# dk_Host_Os()
#
#	  Host_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
#
dk_Host_Os() {
	dk_debugFunc 0 1

	###### SET ######
	if [ -n "${1-}" ]; then
		export Host_Os="${1}"
	
	###### GET ######	
	else
		if [ "${OS-}" = "Windows_NT" ]; then
			[ -z "${Host_Os-}" ]     && Host_Os="Windows"
		fi
		
#		if dk_call dk_commandExists clang; then  
#			Clang_Tuple=$(try clang -dumpmachine)
#			remainder="${Clang_Tuple}"
#			Clang_Arch="${remainder%%-*}"; remainder="${remainder#*-}"
#			Clang_Vendor="${remainder%%-*}"; remainder="${remainder#*-}"
#			Clang_Os="${remainder%%-*}"; remainder="${remainder#*-}"
#			Clang_Env="${remainder%%-*}"; remainder="${remainder#*-}"		
#			[ -z "${Host_Tuple-}" ]	&& Host_Tuple=${Clang_Tuple}
#			[ -z "${Host_Arch-}" ]		&& Host_Arch=${Clang_Arch}
#			[ -z "${Host_Vendor-}" ]	&& Host_Vendor=${Clang_Vendor}
#			[ -z "${Host_Os-}" ]		&& Host_Os=${Clang_Os}
#			[ -z "${Host_Env-}" ]		&& Host_Env=${Clang_Env}
#		fi
#		if dk_call dk_commandExists gcc; then
#			Gcc_Tuple=$(try gcc -dumpmachine)
#			remainder="${Gcc_Tuple}"
#			Gcc_Arch="${remainder%%-*}"; remainder="${remainder#*-}"
#			Gcc_Vendor="${remainder%%-*}"; remainder="${remainder#*-}"
#			Gcc_Os="${remainder%%-*}"; remainder="${remainder#*-}"
#			Gcc_Env="${remainder%%-*}"; remainder="${remainder#*-}"
#			[ -z "${Host_Tuple-}" ]		&& Host_Tuple=${Gcc_Tuple}
#			[ -z "${Host_Arch-}" ]		&& Host_Arch=${Gcc_Arch}
#			[ -z "${Host_Vendor-}" ]	&& Host_Vendor=${Gcc_Vendor}
#			[ -z "${Host_Os-}" ]		&& Host_Os=${Gcc_Os}
#			[ -z "${Host_Env-}"	]		&& Host_Env=${Gcc_Env}
#		fi
#		if dk_call dk_commandExists bash; then
#			Bash_Tuple=$(bash -c "builtin echo \${MACHTYPE}")
#			remainder="${Bash_Tuple}"
#			Bash_Arch="${remainder%%-*}"; remainder="${remainder#*-}"
#			Bash_Vendor="${remainder%%-*}"; remainder="${remainder#*-}"
#			Bash_Os="${remainder%%-*}"; remainder="${remainder#*-}"
#			Bash_Env="${remainder%%-*}"; remainder="${remainder#*-}"
#			[ -z "${Host_Tuple-}" ]		&& Host_Tuple=${Bash_Tuple}
#			[ -z "${Host_Arch-}" ]		&& Host_Arch=${Bash_Arch}
#			[ -z "${Host_Vendor-}" ]	&& Host_Vendor=${Bash_Vendor}
#			[ -z "${Host_Os-}" ]		&& Host_Os=${Bash_Os}
#			[ -z "${Host_Env-}" ]		&& Host_Env=${Bash_Env}
#		fi
#		if dk_call dk_commandExists uname; then
#			Uname="$(uname)"         && dk_call dk_printVar Uname
#			Uname_a="$(uname -a)"    && dk_call dk_printVar Uname_a
#			Uname_s="$(uname -s)"    && dk_call dk_printVar Uname_s
#			Uname_n="$(uname -n)"    && dk_call dk_printVar Uname_n	
#			Uname_r="$(uname -r)"    && dk_call dk_printVar Uname_r
#			Uname_v="$(uname -v)"    && dk_call dk_printVar Uname_v
#			Uname_m="$(uname -m)"    && dk_call dk_printVar Uname_m
#			Uname_p="$(uname -p)"    && dk_call dk_printVar Uname_p
#			Uname_i="$(uname -i)"    && dk_call dk_printVar Uname_i
#			Uname_o="$(uname -o)"    && dk_call dk_printVar Uname_o
#			Uname_Arch="$(uname -m)" && dk_call dk_printVar Uname_Arch
#			Uname_SUBArch=""
#			if [ "$(uname -s)" = "Darwin" ]; then
#				Uname_Vendor="-apple"
#			else
#				Uname_Vendor="-unknown"
#			fi
#			if [ "$(uname -s)" = "darwin" ]; then
#				Uname_Os="$(uname -s)$(try uname -r)"
#			else
#				Uname_Os="$(uname -s)"
#			fi
#			if dk_call dk_containsCI "$(uname -o)" "GNU"; then
#				Uname_Env="-gnu"
#			elif dk_call dk_containsCI "$(uname -o)" "Android"; then
#				Uname_Env="-android" #FIXME: need abi number I.E. -android24
#			else
#				Uname_Env="gcc" # Default
#			fi
#			Uname_Tuple=${Uname_Arch}${Uname_SUBArch}${Uname_Vendor}${Uname_Os}${Uname_Env}
#			[ -z "${Host_Tuple}" ]	&& Host_Tuple=${Uname_Tuple}
#			[ -z "${Host_Arch}" ]   && Host_Arch=${Uname_Arch}
#			[ -z "${Host_Vendor}" ] && Host_Vendor=${Uname_Vendor}
#			[ -z "${Host_Os-}" ]    && Host_Os=${Uname_Os}
#			[ -z "${Host_Env}" ]    && Host_Env=${Uname_Env}
#		fi
	fi
	
	export ${Host_Os}_Host=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	###### GET ######
    dk_call dk_Host_Os
	dk_call dk_printVar Host_Os
	dk_call dk_printVar ${Host_Os}_Host
	
	###### SET ######
	dk_call dk_Host_Os "Linux"
	dk_call dk_printVar Host_Os
	dk_call dk_printVar ${Host_Os}_Host
}