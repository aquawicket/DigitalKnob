#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDom/DKDomHTMLElement.h"


/////////////////////////////
bool DKDomHTMLElement::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKDom/DKDomHTMLElement.js");
	return true;
}


#endif //USE_DKDuktape