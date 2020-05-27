#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKRocketHTMLElement.h"
#include "DKRocket/DKRocket.h"


//////////////////////////
bool DKRocketHTMLElement::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKRocket/DKRocketHTMLElement.js");
	return true;
}


#endif //USE_DKDuktape