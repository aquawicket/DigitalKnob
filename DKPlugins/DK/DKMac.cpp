#include "stdafx.h"
#ifdef MAC
#include "DKMac.h"

///////////////////////////////////////////////////
bool DKMac::SetMainThreadNow(unsigned long int& id)
{
	id = (unsigned long int)pthread_self();
	return true;
}

//////////////////////////////////////////////
bool DKMac::GetThreadId(unsigned long int& id)
{
	id = (unsigned long int)pthread_self();
	return true;
}

///////////////////////////////////////
bool DKMac::GetMousePos(int& x, int& y)
{
	//NSPoint mouseLoc;
	//mouseLoc = [NSEvent mouseLocation]; //get current mouse position
	//NSLog(@"Mouse location: %f %f", mouseLoc.x, mouseLoc.y);
	x = 0;//mouseLoc.x;
	y = 0;//mouseLoc.y;
	return true;
}

#endif //MAC