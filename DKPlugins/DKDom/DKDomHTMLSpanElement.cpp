//https://developer.mozilla.org/en-US/docs/Web/API/HTMLSpanElement

#include "DK/DKApp.h"
#include "DKDom.h"
#include "DKDom/DKDomHTMLSpanElement.h"

bool DKDomHTMLSpanElement::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKDom/DKDomHTMLSpanElement.js");
	return true;
}
