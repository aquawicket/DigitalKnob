#include "dk_verbose.hpp"


<<<<<<< HEAD

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main() {
	dk_verbose("test dk_verbose()");
    return 0;
=======
//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	return dk_verbose("test dk_verbose()");
>>>>>>> Development
}
#endif
