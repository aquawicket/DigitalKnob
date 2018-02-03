#include "DK/stdafx.h"
#include "DKRocketIframe/DKRocketIframe.h"

//TODO 

///////////////////////////
bool DKRocketIframe::Init()
{
	DKString _data = toString(data, ",");
	//DKLog("DKCef::Init("+_data+")\n", DKDEBUG);
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
	return true;
}