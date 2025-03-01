#include "dk_todo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_todo("test dk_todo() \n");
	exit_status = dk_todo("test dk_todo() with number: %d\n", TODO);
	exit_status = dk_todo("test dk_todo() with string: %s\n", "TODO string");
	return exit_status;
}
#endif
