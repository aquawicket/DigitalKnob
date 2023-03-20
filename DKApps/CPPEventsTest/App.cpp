#include "DK/stdafx.h"

#include "App.h"


bool App::Init(){
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	DKClass::DKCreate("DKConsoleWindow");
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	DKINFO("App::End() \n");
	return true;
}