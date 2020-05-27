#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKHTMLElement.h"
#include "DKRocket/DKRocket.h"


//////////////////////////
bool DKHTMLElement::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKRocket/DKHTMLElement.js");
	return true;
}


#endif //USE_DKDuktape