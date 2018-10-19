#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKDuktape/DKDuktape.h"
#include "DKDuktape/DKJavascript.h"

/////////////////////////
bool DKJavascript::Init()
{
	DKDebug();
	//data = ("DKJavascript", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKLog("DKJavascript::Init("+_data+"): missing parameters. \n", DKERROR);
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKLog("DKJavascript::Init("+_data+"): too many parameters. \n", DKERROR);
	}
	
    DKString file = DKFile::local_assets+data[1];
	if(!DKDuktape::LoadFile(file)){ return false; }
	DKDuktape::CallInit(file);
	return true;
}

////////////////////////
bool DKJavascript::End()
{
	DKDebug();
    DKString file = DKFile::local_assets+data[1];
	DKDuktape::CallEnd(file);
	return true;
}