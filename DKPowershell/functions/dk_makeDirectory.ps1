if (!$DKINIT){ . $PWD\DK.ps1 }

####################################################################
# dk_makeDirectory(<path>)
#
#
function Global:dk_makeDirectory () {
	dk_debugFunc
	
	#set "path=%~1"
    #if NOT exist "%path%" mkdir "%path%"
}




function Global:DKTEST() { ###########################################################################################
	
	dk_makeDirectory "MadeDirectory"
	
}