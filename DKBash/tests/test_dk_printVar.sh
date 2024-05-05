#!/bin/sh

###### Load Function files ######
. ../functions/DK

var="a variable"

arr[0]="an array variable, element 0"
arr[1]="an array variable, element 1"

func () {
	echo "a function"
}

#all="variable using a shared name"

all[0]="and array variable"

all () {
	echo "function using a shared name"
}


###################################
dk_printVar var
dk_printVar arr
dk_printVar func
dk_printVar all
dk_printVar undefined

exec $SHELL