#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKHTMLElement.h"
#include "DKRml/DKRml.h"


///////////////////////
bool DKHTMLElement::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKRml/DKHTMLElement.js");
	return true;
}


#endif //USE_DKDuktape