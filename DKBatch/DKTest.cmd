@echo off
setlocal EnableDelayedExpansion

echo DKTest.cmd()

echo cls && cls && cls

::::::: Load Function files :::::::
call functions\DK.cmd


call dk_message dk_message
call dk_debug dk_debug
call dk_warning dk_warning
call dk_debug "SCRIPT(%*)"
set "TEST_VAR=this is a test variable"
call dk_print_var TEST_VAR


::::::::: main ::::::::::
:main () {
	call dk_debug "main(%*)"
	
	echo. && echo ######################## TEST FIELD ######################## && echo.

::	#printenv
::	
::	:: https://www.baeldung.com/linux/find-current-shell
::	$echo "readlink /proc/\$\$/exe = $(readlink /proc/$$/exe)"
::	$echo "cat /proc/\$\$/cmdline = cat /proc/$$/cmdline"
::	$echo "\$0 = $0"
::	$echo "\$SHELL = $SHELL"
::	$echo "\$BASH = $BASH"
::	$echo "\$PS1 = $PS1"
::	$echo "\$PS2 = $PS2"
::	$echo "\$PS3 = $PS3"
::	$echo "\$PS4 = $PS4"
::	$echo "\$version = $version"
::	$echo "\$shell = $shell"
::	$echo "\$ERRNO = $ERRNO"
::	$echo "\$FCEDIT = $FCEDIT"
::	$echo "\$LINENO = $LINENO"
::	$echo "\$PPID = $PPID"
::	$echo "\$RANDOM = $RANDOM"
::	$echo "\$SECONDS = $SECONDS"
::	$echo "\$TMOU = $TMOU"
::	$echo "ps -p \$\$ -o 'comm=' = $(ps -p $$ -o 'comm=')"
::	$echo "ps -p \$\$ -o 'args=' = $(ps -p $$ -o 'args=')"
::	$echo "ps -o fname --no-headers \$\$ = $(ps -o fname --no-headers $$)"
::	$echo ""
::
::	::::::::::::::::::::::: Test Constructs :::::::::::::::::::::::
::	:: https://tldp.org/LDP/abs/html/testconstructs.html#TTESTREF
::
::	#unset=
::	v_=
::	v_0=0
::	v_1=1
::	v_abc=abc
::
::	$echo "\$unset = $unset"
::	$echo "\$empty = $empty"
::	$echo "\$v_0 =   $v_0"
::	$echo "\$v_1 =   $v_1"
::	$echo "\$v_abc = $v_abc"
::	$echo ""
::
::	### test ###
::	evaluate test  
::	evaluate test 0
::	evaluate test 1
::	evaluate test abc
::	evaluate test unset
::	evaluate test v_
::	evaluate test v_0
::	evaluate test v_1
::	evaluate test v_abc
::	evaluate test $unset
::	evaluate test $v_
::	evaluate test $v_0
::	evaluate test $v_1
::	evaluate test $v_abc
::	evaluate test " "
::	evaluate test "0"
::	evaluate test "1"
::	evaluate test "'abc'"
::	evaluate test '"unset"'
::	evaluate test 'v_'
::	evaluate test "v_0"
::	evaluate test "v_1"
::	evaluate test "v_abc"
::	$echo ""
::	
::	evaluate [        ] 
::	evaluate [ 0      ]
::	evaluate [ 1      ]
::	evaluate [ abc    ]
::	evaluate [ v_     ]
::	evaluate [ v_0    ]
::	evaluate [ v_1    ]
::	evaluate [ v_abc  ]
::	evaluate [ $v_    ]
::	evaluate [ $v_0   ]
::	evaluate [ $v_1   ]
::	evaluate [ $v_abc ]
::	$echo ""
::	
::	### if [ ] ###
::	if [   ]; then $echo 'if [   ] is $true'; else $echo 'if [   ] is $false'; fi
::	if [ 0 ]; then $echo "if [ 0 ] is $true"; else $echo "if [ 0 ] is $false"; fi
::	if [ 1 ]; then $echo "if [ 1 ] is $true"; else $echo "if [ 1 ] is $false"; fi
::	$echo ""
::
::	### [ -e ] ###
::	[ -e        ] && $echo "[ -e        ] is $true" || $echo "[ -e        ] is $false"
::	[ -e $BLANK ] && $echo "[ -e \$BLANK ] is $true" || $echo "[ -e \$BLANK ] is $false"
::	[ -e $HOME  ] && $echo "[ -e \$HOME  ] is $true" || $echo "[ -e \$HOME  ] is $false"
::	$echo ""
::
::	################ (BASH ONLY) #################
::	### [[ ]] ### (BASH ONLY) 
::	#           $echo "[[   ]] is $error"
::	#[[ 0 ]] && $echo "[[ 0 ]] is $true" || $echo "[[ 0 ]] is $false"
::	#[[ 1 ]] && $echo "[[ 1 ]] is $true" || $echo "[[ 1 ]] is $false"
::	#$echo ""
::
::	### (( )) ### (BASH ONLY)
::	#((          )) && $echo "((          )) is $true" || $echo "((          )) is $false"	# sh error
::	#((   0      )) && $echo "((   0      )) is $true" || $echo "((   0      )) is $false"
::	#((   1      )) && $echo "((   1      )) is $true" || $echo "((   1      )) is $false"
::	#((  abc     )) && $echo "((  abc     )) is $true" || $echo "((  abc     )) is $false"
::	#((  v_    )) && $echo "((  v_    )) is $true" || $echo "((  v_    )) is $false"
::	#((  v_0   )) && $echo "((  v_0   )) is $true" || $echo "((  v_0   )) is $false"
::	#(( $v_0   )) && $echo "(( \$v_0   )) is $true"|| $echo "(( \$v_0   )) is $false"
::	#((  v_1   )) && $echo "((  v_1   )) is $true" || $echo "((  v_1   )) is $false"
::	#(( $v_1   )) && $echo "(( \$v_1   )) is $true"|| $echo "(( \$v_1   )) is $false"
::	#((  v_abc )) && $echo "((  v_abc )) is $true" || $echo "((  v_abc )) is $false"
::	#(( $v_abc )) && $echo "(( \$v_abc )) is $true"|| $echo "(( \$v_abc )) is $false"
::	#((  ' '     )) && $echo "((  ' '     )) is $true" || $echo "((  ' '     )) is $false"
::	#((  '0'     )) && $echo "((  '0'     )) is $true" || $echo "((  '0'     )) is $false"
::	#((  '1'     )) && $echo "((  '1'     )) is $true" || $echo "((  '1'     )) is $false"
::	#((  'abc'   )) && $echo "(( 'abc '   )) is $true" || $echo "(( 'abc'    )) is $false"
::	#$echo ""
::
::	### if [[ ]] ### (BASH ONLY)
::	#                $echo "if [[   ]] is $error"
::	#if [[ 0 ]]; then $echo "if [[ 0 ]] is $true"; else $echo "if [[ 0 ]] is $false"; fi
::	#if [[ 1 ]]; then $echo "if [[ 1 ]] is $true"; else $echo "if [[ 1 ]] is $false"; fi
::	#$echo ""
::
::	### if (( )) ### (BASH ONLY)
::	#if ((   )); then $echo "if ((   )) is $true"; else $echo "if ((   )) is $false"; fi    sh error
::	#if (( 0 )); then $echo "if (( 0 )) is $true"; else $echo "if (( 0 )) is $false"; fi
::	#if (( 1 )); then $echo "if (( 1 )) is $true"; else $echo "if (( 1 )) is $false"; fi
::	#$echo ""
::
::	### [[ -e ]] ### (BASH ONLY)
::	#                   $echo "[[ -e        ]] is $error"
::	#[[ -e $BLANK ]] && $echo "[[ -e \$BLANK ]] is $true" || $echo "[[ -e \$BLANK ]] is $false"
::	#[[ -e $HOME  ]] && $echo "[[ -e \$HOME  ]] is $true" || $echo "[[ -e \$HOME  ]] is $false"
::	#$echo ""
::
::	### (( -e )) ### (BASH ONLY)
::	#(( -e        )) && $echo "(( -e        )) is $true" || $echo "(( -e        )) is $false"
::	#(( -e $BLANK )) && $echo "(( -e \$BLANK )) is $true" || $echo "(( -e \$BLANK )) is $false"
::	#				   $echo "(( -e HOME    )) is $error"
::	#				   $echo "(( -e \$HOME  )) is $error"
::	#$echo ""
::
::	$echo "\n############################################################\n"
::	
::	print_stack
::	dk_stacktrace
goto:eof
::
::::::::: print_stack() :::::::
::print_stack () {
::	dk_debug "print_stack($@)"
::  if [ $BASH ]; then
::		#echo "stack_size: ${#FUNCNAME[@]}"
::		(( n=${#FUNCNAME[@]}-1 ))
::        for I in ${FUNCNAME[@]}
::	    do
::		    echo "FUNCNAME[$n]: $I"
::			(( n-- ))
::	    done
::    fi
::goto:eof
::
::::::::: evaluate() ::::::::
::evaluate () {
::	#dk_debug "evaluate($@)"
::	export _true="${green}true${clr}"
::	export _false="${red}false${clr}"
::	export _error="${red}!! SYNTAX ERROR !!${clr}"
::	$@ && $echo "evaluate($@) is $_true" || $echo "evaluate($@) is $_false"
::	return $?
::goto:eof
::
::test_function () {
::	dk_debug "test_function($@)"
::	#args=( "$@" )
::	loop_array "$@"
::	exit_code="$?"
::goto:eof
::
::loop_array () {
::	dk_debug "loop_array($@)"
::	for I in "${@}"
::	do
::		echo "Param: $I"
::	done
::goto:eof
::
::escape_quotes () {
::	dk_debug "escape_quotes($@)"
::	input=$1
::	output=$(echo $input  | sed 's/"/\\"/g')
::	eval $2=$output
::goto:eof
::
::
::str='The dog is "very" beautiful'
::
::
::[ "$@" -ne "" ] && "$@"
::main "$@"
::
::#exit $?  #exitcode