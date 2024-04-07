#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh


dk_echo "TEST"

dk_message "message"
dk_debug "debug"
dk_warning "warning"
dk_debug "SCRIPT($@)"
TEST_VAR="this is a test variable"
dk_print_var TEST_VAR

###### main ######
main() {
	dk_debug "main($@)"	
	dk_echo "\n######################## TEST FIELD ########################\n"

	: '
	This is a
	very neat comment
	in bash
	'

	# https://www.baeldung.com/linux/find-current-shell
	dk_echo "readlink /proc/\$\$/exe = $(readlink /proc/$$/exe)"
	dk_echo "cat /proc/\$\$/cmdline = cat /proc/$$/cmdline"
	dk_echo "\$0 = $0"
	dk_echo "\$SHELL = $SHELL"
	dk_echo "\$BASH = $BASH"
	dk_echo "\$PS1 = $PS1"
	dk_echo "\$PS2 = $PS2"
	dk_echo "\$PS3 = $PS3"
	dk_echo "\$PS4 = $PS4"
	dk_echo "\$version = $version"
	dk_echo "\$shell = $shell"
	dk_echo "\$ERRNO = $ERRNO"
	dk_echo "\$FCEDIT = $FCEDIT"
	dk_echo "\$LINENO = $LINENO"
	dk_echo "\$PPID = $PPID"
	dk_echo "\$RANDOM = $RANDOM"
	dk_echo "\$SECONDS = $SECONDS"
	dk_echo "\$TMOU = $TMOU"
	dk_echo "ps -p \$\$ -o 'comm=' = $(ps -p $$ -o 'comm=')"
	dk_echo "ps -p \$\$ -o 'args=' = $(ps -p $$ -o 'args=')"
	dk_echo "ps -o fname --no-headers \$\$ = $(ps -o fname --no-headers $$)"
	dk_echo ""

	####################### Test Constructs #######################
	# https://tldp.org/LDP/abs/html/testconstructs.html#TTESTREF

	#unset=
	v_=
	v_0=0
	v_1=1
	v_abc=abc

	dk_echo "\$unset = $unset"
	dk_echo "\$empty = $empty"
	dk_echo "\$v_0 =   $v_0"
	dk_echo "\$v_1 =   $v_1"
	dk_echo "\$v_abc = $v_abc"
	dk_echo ""


	### test ###
	evaluate test  
	evaluate test 0
	evaluate test 1
	evaluate test abc
	evaluate test unset
	evaluate test v_
	evaluate test v_0
	evaluate test v_1
	evaluate test v_abc
	evaluate test $unset
	evaluate test $v_
	evaluate test $v_0
	evaluate test $v_1
	evaluate test $v_abc
	evaluate test " "
	evaluate test "0"
	evaluate test "1"
	evaluate test "'abc'"
	evaluate test '"unset"'
	evaluate test 'v_'
	evaluate test "v_0"
	evaluate test "v_1"
	evaluate test "v_abc"
	dk_echo ""
	
	evaluate [        ] 
	evaluate [ 0      ]
	evaluate [ 1      ]
	evaluate [ abc    ]
	evaluate [ v_     ]
	evaluate [ v_0    ]
	evaluate [ v_1    ]
	evaluate [ v_abc  ]
	evaluate [ $v_    ]
	evaluate [ $v_0   ]
	evaluate [ $v_1   ]
	evaluate [ $v_abc ]
	dk_echo ""
	
	### if [ ] ###
	if [   ]; then dk_echo 'if [   ] is $true'; else dk_echo 'if [   ] is $false'; fi
	if [ 0 ]; then dk_echo "if [ 0 ] is $true"; else dk_echo "if [ 0 ] is $false"; fi
	if [ 1 ]; then dk_echo "if [ 1 ] is $true"; else dk_echo "if [ 1 ] is $false"; fi
	dk_echo ""

	### [ -e ] ###
	[ -e        ] && dk_echo "[ -e        ] is $true" || dk_echo "[ -e        ] is $false"
	[ -e $BLANK ] && dk_echo "[ -e \$BLANK ] is $true" || dk_echo "[ -e \$BLANK ] is $false"
	[ -e $HOME  ] && dk_echo "[ -e \$HOME  ] is $true" || dk_echo "[ -e \$HOME  ] is $false"
	dk_echo ""

	################ (BASH ONLY) #################
	### [[ ]] ### (BASH ONLY) 
	#           dk_echo "[[   ]] is $error"
	#[[ 0 ]] && dk_echo "[[ 0 ]] is $true" || dk_echo "[[ 0 ]] is $false"
	#[[ 1 ]] && dk_echo "[[ 1 ]] is $true" || dk_echo "[[ 1 ]] is $false"
	#dk_echo ""

	### (( )) ### (BASH ONLY)
	#((          )) && dk_echo "((          )) is $true" || dk_echo "((          )) is $false"	# sh error
	#((   0      )) && dk_echo "((   0      )) is $true" || dk_echo "((   0      )) is $false"
	#((   1      )) && dk_echo "((   1      )) is $true" || dk_echo "((   1      )) is $false"
	#((  abc     )) && dk_echo "((  abc     )) is $true" || dk_echo "((  abc     )) is $false"
	#((  v_    )) && dk_echo "((  v_    )) is $true" || dk_echo "((  v_    )) is $false"
	#((  v_0   )) && dk_echo "((  v_0   )) is $true" || dk_echo "((  v_0   )) is $false"
	#(( $v_0   )) && dk_echo "(( \$v_0   )) is $true"|| dk_echo "(( \$v_0   )) is $false"
	#((  v_1   )) && dk_echo "((  v_1   )) is $true" || dk_echo "((  v_1   )) is $false"
	#(( $v_1   )) && dk_echo "(( \$v_1   )) is $true"|| dk_echo "(( \$v_1   )) is $false"
	#((  v_abc )) && dk_echo "((  v_abc )) is $true" || dk_echo "((  v_abc )) is $false"
	#(( $v_abc )) && dk_echo "(( \$v_abc )) is $true"|| dk_echo "(( \$v_abc )) is $false"
	#((  ' '     )) && dk_echo "((  ' '     )) is $true" || dk_echo "((  ' '     )) is $false"
	#((  '0'     )) && dk_echo "((  '0'     )) is $true" || dk_echo "((  '0'     )) is $false"
	#((  '1'     )) && dk_echo "((  '1'     )) is $true" || dk_echo "((  '1'     )) is $false"
	#((  'abc'   )) && dk_echo "(( 'abc '   )) is $true" || dk_echo "(( 'abc'    )) is $false"
	#dk_echo ""

	### if [[ ]] ### (BASH ONLY)
	#                dk_echo "if [[   ]] is $error"
	#if [[ 0 ]]; then dk_echo "if [[ 0 ]] is $true"; else dk_echo "if [[ 0 ]] is $false"; fi
	#if [[ 1 ]]; then dk_echo "if [[ 1 ]] is $true"; else dk_echo "if [[ 1 ]] is $false"; fi
	#dk_echo ""

	### if (( )) ### (BASH ONLY)
	#if ((   )); then dk_echo "if ((   )) is $true"; else dk_echo "if ((   )) is $false"; fi    sh error
	#if (( 0 )); then dk_echo "if (( 0 )) is $true"; else dk_echo "if (( 0 )) is $false"; fi
	#if (( 1 )); then dk_echo "if (( 1 )) is $true"; else dk_echo "if (( 1 )) is $false"; fi
	#dk_echo ""

	### [[ -e ]] ### (BASH ONLY)
	#                   dk_echo "[[ -e        ]] is $error"
	#[[ -e $BLANK ]] && dk_echo "[[ -e \$BLANK ]] is $true" || dk_echo "[[ -e \$BLANK ]] is $false"
	#[[ -e $HOME  ]] && dk_echo "[[ -e \$HOME  ]] is $true" || dk_echo "[[ -e \$HOME  ]] is $false"
	#dk_echo ""

	### (( -e )) ### (BASH ONLY)
	#(( -e        )) && dk_echo "(( -e        )) is $true" || dk_echo "(( -e        )) is $false"
	#(( -e $BLANK )) && dk_echo "(( -e \$BLANK )) is $true" || dk_echo "(( -e \$BLANK )) is $false"
	#				   dk_echo "(( -e HOME    )) is $error"
	#				   dk_echo "(( -e \$HOME  )) is $error"
	#dk_echo ""

	dk_echo "\n############################################################\n"
	
	func_2
}

func_2 () {
	dk_debug "func_2($@)"
	dk_stacktrace
}

###### evaluate() ######
evaluate () {
	#dk_debug "evaluate($@)"
	export _true="${green}true${clr}"
	export _false="${red}false${clr}"
	export _error="${red}!! SYNTAX ERROR !!${clr}"
	$@ && dk_echo "evaluate($@) is $_true" || dk_echo "evaluate($@) is $_false"
	return $?
}

test_function () {
	#dk_debug "test_function($@)"
	#args=( "$@" )
	loop_array "$@"
	exit_code="$?"
}

loop_array () {
	#dk_debug "loop_array($@)"
	for I in "${@}"
	do
		echo "Param: $I"
	done
}

escape_quotes () {
	#dk_debug "escape_quotes($@)"
	input=$1
	output=$(echo $input  | sed 's/"/\\"/g')
	eval $2=$output
}



#[ "$@" -ne "" ] && "$@"
main "$@"

#exit $?  #exitcode