#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKXMLHttpRequest.h"


/////////////////////////////
bool DKXMLHttpRequest::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKXMLHttpRequest_send", DKXMLHttpRequest::send);
	
	DKClass::DKCreate("DKDuktape/DKXMLHttpRequest.js");
	return true;
}

////////////////////////////////////////////
int DKXMLHttpRequest::send(duk_context* ctx)
{
	//TODO
	return false;
}


#endif //USE_DKDuktape