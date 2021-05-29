#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKRocketHTMLCollection.h"
#include "DKRocket/DKRocket.h"


/////////////////////////////
bool DKRocketHTMLCollection::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKRocket/DKRocketHTMLCollection.js");
	return true;
}


#endif //USE_DKDuktape