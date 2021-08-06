#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"

//TODO 

///////////////////////////
bool DKRocketIframe::Init()
{
	DKDEBUGFUNC();
	DKString _data = toString(data, ",");
	//DKINFO("DKCef::Init("+_data+")\n");
	if(data.size() > 4){
		//id = data[1];
		//top = toInt(data[2]);
		//left = toInt(data[3]);
		//width = toInt(data[4]);
		//height = toInt(data[5]);
	}
	return true;
}

//////////////////////////
bool DKRocketIframe::End()
{
	DKDEBUGFUNC();
	return true;
}