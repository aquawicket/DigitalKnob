#include "DK/DKApp.h"
#include "DKDom/DKDomXMLHttpRequestEventTarget.h"

bool DKDomXMLHttpRequestEventTarget::Init(){
	DKDEBUGFUNC();
	
	DKClass::DKCreate("DKDom/DKDomXMLHttpRequestEventTarget.js");
	return true;
}