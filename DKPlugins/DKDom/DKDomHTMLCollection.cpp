#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKHTMLCollection.h"
#include "DKRml/DKRml.h"


/////////////////////////////
bool DKHTMLCollection::Init()
{
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKRml/DKHTMLCollection.js");
	return true;
}


#endif //USE_DKDuktape