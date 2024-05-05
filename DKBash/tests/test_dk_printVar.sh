#!/bin/sh

###### Load Function files ######
. ../functions/DK

var="a variable"

arr[0]="an array variable, element 0"
arr[1]="an array variable, element 1"

func () {
	echo "a function"
}

alias alias_="an alias"

all="a variable, using a shared name"

all[0]="an array variable, using a shared name"

all () {
	echo "a function, using a shared name"
}

alias all="an alias"

###################################
dk_printVar var
dk_printVar arr
dk_printVar func
dk_printVar alias_
dk_printVar all
dk_printVar undefined

exec $SHELL