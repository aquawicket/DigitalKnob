#include "DK/stdafx.h"

#include "App.h"
#include "TEST_Event.h"
#include "TEST_CustomEvent.h"


bool App::Init() {
	DKDEBUGFUNC();
	
	DKClass::DKCreate("TEST_Event");
	DKClass::DKCreate("TEST_CustomEvent");
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
