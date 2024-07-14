
#include DKC_FUNCTIONS_DIR+"/DK.h"

//##################################################################################
//# dk_realpath(path) -> rtn_var
//#
//#    C: https://pubs.opengroup.org/onlinepubs/9699919799/functions/realpath.html
//#
char* dk_realpath(const char *path, char *rtn_var) {
	dk_debugFunc()
#	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
#	$realpath = Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror #Calls Resolve-Path but works for files that don't exist.
#	if(-not($realpath)){ $realpath = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	dk_printVar(realpath);
	return realpath;
}






//####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
void DKTEST() { 
	dk_debugFunc()
	
	char* realpath = dk_realpath("dk_load.ps1");
	dk_echo("realpath = "+realpath);
}