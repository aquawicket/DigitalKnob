#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKOcr/DKOcr.h"
#include "DKOcr/DKOcrV8.h"

////////////////////
bool DKOcrV8::Init()
{
	DKLog("DKOcrV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKOcr_ImageToText", DKOcrV8::ImageToText);
	return true;
}

///////////////////
bool DKOcrV8::End()
{
	DKLog("DKOcrV8::End()\n", DKDEBUG);
	return true;
}



/////////////////////////////////////////////////////////
bool DKOcrV8::ImageToText(CefArgs args, CefReturn retval)
{
	DKString file = args->GetString(0);
	DKString text;
	if(!DKOcr::ImageToText(file, text)){ return false; }
	retval->SetString(0, text);
	return true;
}

#endif //USE_DKCef