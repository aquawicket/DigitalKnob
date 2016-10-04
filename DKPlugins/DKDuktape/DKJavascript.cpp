#include "stdafx.h"
#include "DKJavascript.h"
#include "DKDuktape.h"
#include "DKFile.h"

/////////////////////////
void DKJavascript::Init()
{
	//data = ("DKJavascript", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKLog("DKJavascript::Init("+_data+"): missing parameters. \n", DKERROR);
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKLog("DKJavascript::Init("+_data+"): too many parameters. \n", DKERROR);
	}
	
    DKString user = DKFile::local_assets+data[1];
	if(!DKDuktape::LoadFile(user)){ return; }
	DKDuktape::CallInit(user);
}

////////////////////////
void DKJavascript::End()
{
    DKString user = DKFile::local_assets+data[1];
	DKDuktape::CallEnd(user);
	return;
}