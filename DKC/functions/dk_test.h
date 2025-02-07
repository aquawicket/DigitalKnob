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
//	printf("         ERRORLEVEL = %s\n", ERRORLEVEL);
//	printf("                LVL = %s\n", LVL);
	printf("           __DATE__ = %s\n", DKDATE);
	printf("           __TIME__ = %s\n", DKTIME);
//	printf("           __CMND__ = %s\n", __CMND__);/
	printf("           __FILE__ = %s\n", __FILE__);
	printf("           __LINE__ = %d\n", __LINE__);
	printf("       __FUNCTION__ = %s\n", __FUNCTION__);
	printf("           __ARGC__ = %d\n", __ARGC__);
	printf("           __ARGV__ = %s\n", __ARGV__);
	printf("      DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	printf("       DKSCRIPT_DIR = %s\n", DKSCRIPT_DIR);
	printf("      DKSCRIPT_FILE = %s\n", DKSCRIPT_FILE);
	printf("      DKSCRIPT_NAME = %s\n", DKSCRIPT_NAME);
	printf("       DKSCRIPT_EXT = %s\n", DKSCRIPT_EXT);
	printf("      DKSCRIPT_ARGS = %s\n", DKSCRIPT_ARGS);
	printf("         DKHOME_DIR = %s\n", DKHOME_DIR);
	printf("        DKCACHE_DIR = %s\n", DKCACHE_DIR);
	printf("      DKDESKTOP_DIR = %s\n", DKDESKTOP_DIR);
	printf("        DIGITALKNOB = %s\n", DIGITALKNOB);
	printf("    DIGITALKNOB_DIR = %s\n", DIGITALKNOB_DIR);
	printf("     DKDOWNLOAD_DIR = %s\n", DKDOWNLOAD_DIR);
	printf("        DKTOOLS_DIR = %s\n", DKTOOLS_DIR);
	printf("           DKBRANCH = %s\n", DKBRANCH);
	printf("       DKBRANCH_DIR = %s\n", DKBRANCH_DIR);
	printf("     DK3RDPARTY_DIR = %s\n", DK3RDPARTY_DIR);
	printf("         DKAPPS_DIR = %s\n", DKAPPS_DIR);
	printf("            DKC_DIR = %s\n", DKC_DIR);
	printf("  DKC_FUNCTIONS_DIR = %s\n", DKC_FUNCTIONS_DIR);
	printf(" DKC_FUNCTIONS_DIR_ = %s\n", DKC_FUNCTIONS_DIR_);

//	setGlobal(GLOBAL_VAR, "This is a global variable");
//	setReturn(RETURN_VAR, "This is a return variable");

//	printf("GLOBAL_VAR = %s\n", GLOBAL_VAR);
//	printf("RETURN_VAR = %s\n", RETURN_VAR);
	return 0;
};


#endif //dk_test_h