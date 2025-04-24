#include "dk_fixme.hpp"


<<<<<<< HEAD

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main() {
	dk_fixme("test dk_fixme()");
    return 0;
=======
//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	return dk_fixme("test dk_fixme()");
>>>>>>> Development
}
#endif
