#include "dk_warning.hpp"


<<<<<<< HEAD

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main() {
	dk_warning("test dk_warning()");
    return 0;
=======
//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	return dk_warning("test dk_warning()");
>>>>>>> Development
}
#endif
