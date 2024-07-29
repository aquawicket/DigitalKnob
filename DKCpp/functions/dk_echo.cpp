#include "dk_echo.h"

/*
void dk_echo(const char* message){
	printf("%s\n", message);
}
*/




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main() {
	dk_echo("DKTEST()");
    return 0;
}
#endif
