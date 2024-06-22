#!/bin/sh

function foo(){ echo "foo $1"; }
$(command -v foo 1>nul 2>&1) || function foo(){ echo "foo_fallback $1"; }
#function foo(){ echo "foo $1"; }

#function bar(){ echo "bar $1"; }
$(command -v bar 1>nul 2>&1) || function bar(){ echo "bar_fallback $1"; }
function bar(){ echo "bar $1"; }

#function noob(){ echo "noob $1" }
$(command -v noob 1>nul 2>&1) || function noob(){ echo "noob_fallback $1"; }
#function noob(){ echo "noob $1" }



# We can test to see if a function is available and default to a fallback function if the function does not exist.
# If the function exists any time before or after the declaration of the fallback function, the normal function is used.
# If the normal function is not found, the fallback function is used.
main(){

	foo "sent a string"
	bar "sent a string"
	noob "sent a string"
	
	exec $SHELL
}

main

