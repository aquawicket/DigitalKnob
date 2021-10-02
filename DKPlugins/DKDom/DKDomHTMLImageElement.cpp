//https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement

#include "DK/DKApp.h"
#include "DKDom.h"
#include "DKDom/DKDomHTMLImageElement.h"

bool DKDomHTMLImageElement::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKDom/DKDomHTMLImageElement.js");
	return true;
}
