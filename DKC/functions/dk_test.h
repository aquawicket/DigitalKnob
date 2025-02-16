#pragma once
#ifndef dk_test_h
#define dk_test_h

#include "DK.h"


//################################################################################
//# dk_test(args)
//#
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include "dk_DKHOME_DIR.h"
#include "dk_echo.h"
int dk_test(int __ARGC__, ...){
	//dk_debugFunc 0 99
	
	printf("################# dk_test.h ################\n");
	
	//### args[n] ###
	va_list ap;
	va_start(ap, __ARGC__); /* Before C23: Requires the last fixed parameter (to get the address) */
	char __ARGV__[256];
	strcpy(__ARGV__,"");
	for (int j = 0; j < __ARGC__; j++) { 
		char* temp = va_arg(ap, char*);  /* Increments ap to the next argument. */
		printf("               arg%d = %s\n", j, temp);
		strcat(__ARGV__, temp);
		strcat(__ARGV__, ";");
	}
	va_end(ap);
//	dk_echo("         ERRORLEVEL = %s\n", ERRORLEVEL);
//	dk_echo("                LVL = %s\n", LVL);
	dk_echo("           __DATE__ = %s\n", DKDATE);
	dk_echo("           __TIME__ = %s\n", DKTIME);
//	dk_echo("           __CMND__ = %s\n", __CMND__);/
	dk_echo("           __FILE__ = %s\n", __FILE__);
	dk_echo("           __LINE__ = %d\n", __LINE__);
	dk_echo("       __FUNCTION__ = %s\n", __FUNCTION__);
	dk_echo("           __ARGC__ = %d\n", __ARGC__);
	dk_echo("           __ARGV__ = %s\n", __ARGV__);
	dk_echo("      DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	dk_echo("       DKSCRIPT_DIR = %s\n", DKSCRIPT_DIR);
	dk_echo("      DKSCRIPT_FILE = %s\n", DKSCRIPT_FILE);
	dk_echo("      DKSCRIPT_NAME = %s\n", DKSCRIPT_NAME);
	dk_echo("       DKSCRIPT_EXT = %s\n", DKSCRIPT_EXT);
	dk_echo("      DKSCRIPT_ARGS = %s\n", DKSCRIPT_ARGS);
	dk_echo("         DKHOME_DIR = %s\n", DKHOME_DIR);
	dk_echo("        DKCACHE_DIR = %s\n", DKCACHE_DIR);
	dk_echo("      DKDESKTOP_DIR = %s\n", DKDESKTOP_DIR);
	dk_echo("        DIGITALKNOB = %s\n", DIGITALKNOB);
	dk_echo("    DIGITALKNOB_DIR = %s\n", DIGITALKNOB_DIR);
	dk_echo("     DKDOWNLOAD_DIR = %s\n", DKDOWNLOAD_DIR);
	dk_echo("        DKTOOLS_DIR = %s\n", DKTOOLS_DIR);
	dk_echo("           DKBRANCH = %s\n", DKBRANCH);
	dk_echo("       DKBRANCH_DIR = %s\n", DKBRANCH_DIR);
	dk_echo("     DK3RDPARTY_DIR = %s\n", DK3RDPARTY_DIR);
	dk_echo("         DKCPP_APPS_DIR = %s\n", DKCPP_APPS_DIR);
	dk_echo("            DKC_DIR = %s\n", DKC_DIR);
	dk_echo("  DKC_FUNCTIONS_DIR = %s\n", DKC_FUNCTIONS_DIR);
	dk_echo(" DKC_FUNCTIONS_DIR_ = %s\n", DKC_FUNCTIONS_DIR_);

//	setGlobal(GLOBAL_VAR, "This is a global variable");
//	setReturn(RETURN_VAR, "This is a return variable");

//	printf("GLOBAL_VAR = %s\n", GLOBAL_VAR);
//	printf("RETURN_VAR = %s\n", RETURN_VAR);

//	dk_echo("rtn_var string");
	fprintf(stdout, "rtn_var string\n");
	
	return 0;
};


#endif //dk_test_h