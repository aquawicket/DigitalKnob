#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKDuktape/DKDuktape.h"
#include "DKDuktape/DKJavascript.h"

bool DKJavascript::Init(){
	DKDEBUGFUNC();
	//data = ["DKJavascript", "path/file.ext")
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKERROR("DKJavascript::Init("+_data+"): missing parameters. \n");
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKERROR("DKJavascript::Init("+_data+"): too many parameters. \n");
	}
	DKString file = DKFile::local_assets+data[1];
	if(!DKDuktape::LoadFile(file)){ return false; }
	DKDuktape::CallInit(file);
	return true;
}

bool DKJavascript::End(){
	DKDEBUGFUNC();
	DKString file = DKFile::local_assets + data[1];
	DKDuktape::CallEnd(file);
	return true;
}