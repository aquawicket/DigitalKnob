
#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomWindowEventHandlers.h"
#include "DKRml/DKRml.h"


bool WindowEventHandlers::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKDom/DKDomWindowEventHandlers.js");
	return true;
}
