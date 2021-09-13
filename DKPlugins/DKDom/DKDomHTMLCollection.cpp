//https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection

#include "DK/DKApp.h"
#include "DKDom/DKDomHTMLCollection.h"


bool DKDomHTMLCollection::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKDom/DKDomHTMLCollection.js");
	return true;
}