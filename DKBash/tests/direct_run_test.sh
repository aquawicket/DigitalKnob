#!/bin/sh

export ESC='\x1b'
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

main () {
	export PATH=$PATH:$PWD

	echo -e "\n${magenta}'func1 run_1' >${clr}"
	func1 run_1
	echo -e "${magenta}< 'func1 run_1'${clr}"
	
	echo -e "\n${magenta}'./func1 run_2' >${clr}"
	./func1 run_2
	echo -e "${magenta}< './func1 run_2'${clr}"
	
	echo -e "\n${magenta}'. func1 sourced_1' >${clr}"	
	. func1 sourced_1
	echo -e "${magenta}< '. func1 sourced_1'${clr}"	
	
	echo -e "\n${magenta}'. ./func1 sourced_2' >${clr}"		
	. ./func1 sourced_2
	echo -e "${magenta}< '. ./func1 sourced_2'${clr}"

	exec $SHELL
}

main