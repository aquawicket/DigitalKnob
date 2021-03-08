#include "DK/stdafx.h"
#ifndef WIN32
#include "DKUnix.h"
#include <unistd.h>


/////////////////////////////
bool DKUnix::GetKey(int& key)
{
	DKINFO("Press any key to continue...\n");
	key = getchar();
	return true;
}

////////////////////////////////////
bool DKUnix::Sleep(int milliseconds)
{
	usleep(milliseconds * 1000);
	return true;
}

////////////////////////////////////////////
bool DKUnix::GetUsername(DKString& username)
{
#ifdef LINUX
	char szUserName[64] = {0};
	int nGet = getlogin_r(szUserName, sizeof(szUserName)-1);
	if(0 != nGet){
		DKERROR("DKUnix::GetUsername() failed\n");
		return false;
    }
	DKINFO("USERNAME: "+DKString(szUserName)+"\n");
	char* szHome = getlogin();
	DKINFO("LOGIN: "+DKString(szHome)+"\n");

	username = szUserName;
	return true;
#endif
	return false;
}


#endif //!WIN32
