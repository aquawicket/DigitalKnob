#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDom/DKDomHTMLCollection.h"


////////////////////////////////
bool DKDomHTMLCollection::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKDom/DKDomHTMLCollection.js");
	return true;
}


#endif //USE_DKDuktape