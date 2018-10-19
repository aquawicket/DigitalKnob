#ifdef USE_DKDuktape 
#include "DKXmlJS.h"
#include "DKXml.h"


////////////////////
bool DKXmlJS::Init()
{
	DKDebug();
	DKDuktape::AttachFunction("DKXml_GetXmlNode", DKXmlJS::GetXmlNode);
	return true;
}

/////////////////////////////////////////
int DKXmlJS::GetXmlNode(duk_context* ctx)
{
	DKDebug(ctx);
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