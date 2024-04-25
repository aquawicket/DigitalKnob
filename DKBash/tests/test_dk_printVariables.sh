#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh

main () {
	dk_debugFunc
	
	func1 1 "2" '3'
}

func1 () {
	dk_debugFunc
}

clear
main
dk_pause