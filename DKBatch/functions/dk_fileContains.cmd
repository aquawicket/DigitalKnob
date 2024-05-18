@echo off
call DK

::##################################################################################
::# dk_fileContains(file, string)
::#
::#
:dk_fileContains () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
		
	call dk_todo
	::grep -q "$2" "$1"
}



:DKTEST ########################################################################

	echo "find the needle in the haystack" > fileContains_TEST.txt
	
	
	if call dk_fileContains "fileContains_TEST.txt" "needle" (
		echo "The file contains the string"
	) else (
		echo "The file does NOT contain the string"
	)
	
	
	if call dk_fileContains "fileContains_TEST.txt" "nope" (
		echo "The file contains the string"
	) else (
		echo "The file does NOT contain the string"
	)
