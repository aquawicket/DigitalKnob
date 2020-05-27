#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKHTMLCollection.h"
#include "DKRocket/DKRocket.h"


/////////////////////////////
bool DKHTMLCollection::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKRocket/DKHTMLCollection.js");
	return true;
}


#endif //USE_DKDuktape