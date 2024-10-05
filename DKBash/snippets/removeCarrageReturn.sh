#!/bin/sh

### METHOD 1 ###
MY_VARIABLE=$(cmd.exe /c echo "%MY_VARIABLE%")
MY_VARIABLE=${MY_VARIABLE//$'\r'}
echo "MY_VARIABLE = ${MY_VARIABLE}"

### METHOD 2 ###
MY_VARIABLE=$(cmd.exe /c echo "%MY_VARIABLE%" | tr -d '\r')
echo "MY_VARIABLE = ${MY_VARIABLE}"

### AS A FUNCTION ##
remove_CR() {
	VAR=$1
	RTN_VAR=${VAR//$'\r'}
	eval "$2=$RTN_VAR"
}
