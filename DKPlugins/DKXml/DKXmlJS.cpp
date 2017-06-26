#ifdef USE_DKDuktape 
#include "DKXmlJS.h"
#include "DKXml.h"


////////////////////
void DKXmlJS::Init()
{
	DKLog("DKXmlJS::Init()\n", DKDEBUG);
	
	DKDuktape::AttachFunction("DKXml_GetXmlNode", DKXmlJS::GetXmlNode);
}

/////////////////////////////////////////
int DKXmlJS::GetXmlNode(duk_context* ctx)
{
	DKLog("DKXmlJS::GetXmlNode(duk_context*)\n", DKDEBUG);
	
	DKString file = duk_require_string(ctx, 0);
	DKString tag = duk_require_string(ctx, 1);
	DKXml xml;
	xml.LoadDocument(file);

	DKString libraries;
	if(!xml.GetNodeValue(tag, libraries)){ return 0; }
	duk_push_string(ctx, libraries.c_str());
	return 1;
}

#endif //USE_DKDuktape