#include "DK/DKApp.h"
#include "DKDom/DKDomWindowEventHandlers.h"

bool DKDomWindowEventHandlers::Init(){
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKDom/DKDomWindowEventHandlers.js");
	return true;
}