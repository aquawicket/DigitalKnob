#!/bin/sh

ENABLE_dk_debugFunc=1

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
dk_debugFunc
main
dk_pause