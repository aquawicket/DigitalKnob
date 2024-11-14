#include "dk_test.hpp"



//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main() {
	
	std::string args = "intput args \n";
	
	dk_test(args);
	
	dk_echo("args fter test = "+args);
	
    return 0;
}
#endif
