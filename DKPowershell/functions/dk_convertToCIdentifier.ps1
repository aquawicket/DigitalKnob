if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_convertToCIdentifier){ $dk_convertToCIdentifier = 1 } else{ return }

dk_load dk_error
dk_load dk_printVar
##################################################################################
# dk_convertToCIdentifier(<str>) return <output>
#
#
function Global:dk_convertToCIdentifier( $str ) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$output = $str -replace '\W', '_';
	dk_printVar output
	return $output
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	$myVar = "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :"
	$myAlphaNumericVar = dk_convertToCIdentifier $myVar
	echo "myAlphaNumericVar = ${myAlphaNumericVar}"
}