#include "dk_test_B.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main() {
	
	std::string args = "intput args \n";
	
	dk_test_B(args);
	
	dk_echo("args fter test = "+args);
	
    return 0;
}
#endif
