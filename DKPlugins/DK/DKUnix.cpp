#include "DK/stdafx.h"
#ifndef WIN32
#include "DKUnix.h"
#include <unistd.h>

////////////////////////////////////////////////////
bool DKUnix::SetMainThreadNow(unsigned long int& id)
{
	id = (unsigned long int)pthread_self();
	return true;
}

///////////////////////////////////////////////
bool DKUnix::GetThreadId(unsigned long int& id)
{
	id = (unsigned long int)pthread_self();
	return true;
}

/////////////////////////////
bool DKUnix::GetKey(int& key)
{
	DKLog("Press any key to continue...\n", DKINFO);
	key = getchar();
	return true;
}

////////////////////////////////////
bool DKUnix::Sleep(int milliseconds)
{
	usleep(milliseconds);
	return true;
}

////////////////////////////////////////////
bool DKUnix::GetUsername(DKString& username)
{
#ifdef LINUX
	char szUserName[64] = {0};
	int nGet = getlogin_r(szUserName, sizeof(szUserName)-1);
	if(0 != nGet){
		DKLog("DKUnix::GetUsername() failed. \n", DKERROR);
		return false;
    }
	DKLog("USERNAME: "+DKString(szUserName)+"\n", DKINFO);
	char* szHome = getlogin();
	DKLog("LOGIN: "+DKString(szHome)+"\n", DKINFO);

	username = szUserName;
	return true;
#endif
	return false;
}


#endif //!WIN32