<<<<<<< HEAD
#!/bin/sh
=======
#!/usr/bin/env sh
>>>>>>> Development

LIB_PATH=$(dirname $(realpath ${0}))
PATH=${PATH}:${LIB_PATH}
export BASH="${BASH}"

[ "$(echo -e)" = "" ] && export echo="echo -e" || export echo="echo"

export ESC=
export clr="$ESC[0m"
export black="$ESC[30m"
export red="$ESC[31m"
export green="$ESC[32m"
export yellow="$ESC[33m"
export blue="$ESC[34m"
export magenta="$ESC[35m"
export cyan="$ESC[36m"
export white="$ESC[37m"
	
echo "...Direct Run Test..."

main() {
	$echo "\n${magenta}'. func1 sourced_1' >${clr}"	
	. func1 sourced_1
	$echo "${magenta}< '. func1 sourced_1'${clr}"	
	
	$echo "\n${magenta}'. ./func1 sourced_2' >${clr}"		
	. ./func1 sourced_2
	$echo "${magenta}< '. ./func1 sourced_2'${clr}"
	
	
	$echo "\n${magenta}'func1 run_1' >${clr}"
	func1 run_1
	$echo "${magenta}< 'func1 run_1'${clr}"
	
	$echo "\n${magenta}'./func1 run_2' >${clr}"
	./func1 run_2
	$echo "${magenta}< './func1 run_2'${clr}"
	
	

	exec ${SHELL}
}

main