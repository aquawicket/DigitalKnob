<<<<<<< HEAD
#!/bin/sh
=======
#!/usr/bin/env sh
>>>>>>> Development

foo(){ echo "foo ${1}"; }
$(command -v foo) || foo(){ echo "foo_fallback ${1}"; }
#foo(){ echo "foo ${1}"; }

#bar(){ echo "bar ${1}"; }
$(command -v bar) || bar(){ echo "bar_fallback ${1}"; }
bar(){ echo "bar ${1}"; }

#noob(){ echo "noob ${1}" }
$(command -v noob) || noob(){ echo "noob_fallback ${1}"; }
#noob(){ echo "noob ${1}" }



# We can test to see if a function is available and default to a fallback function if the function does not exist.
# If the function exists any time before or after the declaration of the fallback function, the normal function is used.
# If the normal function is not found, the fallback function is used.
main(){

	foo "sent a string"
	bar "sent a string"
	noob "sent a string"
	
	exec ${SHELL}
}

main

