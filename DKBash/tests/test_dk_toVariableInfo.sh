#!/bin/sh

#HALT_ON_ERROR=0
####################################################################
# test_dk_toVariableInfo.sh
#
#
###### DK_Init ######
. ../functions/DK.sh

dk_echo "\n############ Testing dk_toVariableInfo ############\n"

	MY_VAR="this is my variable"

	# test dk_toVariableInfo with a message containing a valid variable name
	MESSAGE=MY_VAR
	dk_toVariableInfo MESSAGE
	echo ${MESSAGE}

	# test dk_toVariableInfo with a message containing an undefined variable name
	MESSAGE=NO_VAR
	dk_toVariableInfo MESSAGE
	echo ${MESSAGE}

	# test dk_toVariableInfo with a message string containing no variable name
	MESSAGE="this is just a string"
	dk_toVariableInfo MESSAGE
	echo ${MESSAGE}

	# test dk_toVariableInfo with an empty message
	MESSAGE=""
	dk_toVariableInfo MESSAGE
	echo ${MESSAGE}

	# test dk_toVariableInfo with no parameters
	dk_toVariableInfo

dk_echo "\n################### Test done #####################\n"

dk_exit