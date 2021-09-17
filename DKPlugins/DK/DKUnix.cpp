#include "DK/stdafx.h"
#ifndef WIN32
#include "DKUnix.h"
#include <cstdlib>     // GetUsername()  std::getenv()
#include <unistd.h>    // sleep()  / usleep()
/*
#include <pwd.h>       //GetUsername()  getpwuid()/getuid()
#include <unistd.h>    //GetUsername()  getlogin()/getlogin_r()
#include <sys/types.h> //GetUsername()  getpwnam()
*/

bool DKUnix::GetKey(int& key){
	DKINFO("Press any key to continue...\n");
	key = getchar();
	DKINFO("DKUnix::GetKey(): key = "+toString(key)+"\n");
	return true;
}

bool DKUnix::Sleep(int milliseconds){
//#ifdef ANDROID
	//sleep(milliseconds * 1000);
//#else
	usleep(milliseconds * 1000);
//#endif
	return true;
}

bool DKUnix::GetUsername(DKString& username){
#ifdef LINUX
	if (const char* usr_a = std::getenv("USER")){ //'USERNAME' on Windows
		username = usr_a;
		return true;
	}
	/*
	struct passwd* usr_b = getpwuid(getuid());
	if (usr_b) {
		username = usr_b->pw_name;
		return true;
	}
	char* usr_c;
	if ((usr_c = getlogin()) != NULL){
		username = usr_c;
		return true;
	}
	char usr_d[64];
	if (getlogin_r(usr_d, sizeof(usr_d) - 1) != 0) {
		username = usr_d;
		return true;
	}
	char* usr_e;
	struct passwd* pw;
	if ((pw = getpwnam(usr_e)) != NULL){
		username = pw->pw_uid;
		return true;
	}
	return DKERROR("ERROR: cannot get username");
	*/
#endif
	return false;
}


#endif //!WIN32
