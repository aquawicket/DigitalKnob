#include "dk_info.hpp"


//################################################################################
//# dk_info(message)
//#
//#include "dk_log.hpp"
//void dk_info(const char* message){
//	dk_log(message);
//}



//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main() {
	dk_info("test dk_info()");
    return 0;
}
#endif
