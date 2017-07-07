#include "stdafx.h"
#include "DKCss.h"
#include "DKDuktape.h"
#include "DKFile.h"

/////////////////////////
void DKCss::Init()
{
	DKLog("DKCss::Init()\n", DKDEBUG);

	//data = ("DKCss", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKLog("DKCss::Init("+_data+"): missing parameters. \n", DKERROR);
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKLog("DKCss::Init("+_data+"): too many parameters. \n", DKERROR);
	}
	
    DKString file = DKFile::local_assets+data[1];
	//if(!DKDuktape::LoadFile(file)){ return; }
}

////////////////////////
void DKCss::End()
{
	DKLog("DKCss::End()\n", DKDEBUG);
    //DKString file = DKFile::local_assets+data[1];
}