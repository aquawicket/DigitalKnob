#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKOcr/DKOcr.h"
#include "DKOcr/DKOcrV8.h"

////////////////////
bool DKOcrV8::Init()
{
	DKLog("DKOcrV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKOcr_TestInt", DKOcrV8::TestInt);
	DKV8::AttachFunction("DKOcr_TestString", DKOcrV8::TestString);
	DKV8::AttachFunction("DKOcr_TestReturnInt", DKOcrV8::TestReturnInt);
	DKV8::AttachFunction("DKOcr_TestReturnString", DKOcrV8::TestReturnString);

	DKV8::AttachFunction("DKOcr_ImageToText", DKOcrV8::ImageToText);
	return true;
}

///////////////////
bool DKOcrV8::End()
{
	DKLog("DKOcrV8::End()\n", DKDEBUG);
	return true;
}


/////////////////////////////////////////////////////
bool DKOcrV8::TestInt(CefArgs args, CefReturn retval)
{
	DKLog("DKOcrV8::TestInt(CefArgs,CefReturn)\n", DKINFO);

	int data = args->GetInt(0);
	int result = data;
	retval->SetInt(0, result);
	return true;
}

////////////////////////////////////////////////////////
bool DKOcrV8::TestString(CefArgs args, CefReturn retval)
{
	DKLog("DKOcrV8::TestString(CefArgs,CefReturn)\n", DKINFO);

	DKString data = args->GetString(0);
	DKString result = data;
	retval->SetString(0, result);
	return true;
}

///////////////////////////////////////////////////////////
bool DKOcrV8::TestReturnInt(CefArgs args, CefReturn retval)
{
	DKLog("DKOcrV8::TestReturnInt(CefArgs,CefReturn)\n", DKINFO);

	int result = 12345;
	retval->SetInt(0, result);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKOcrV8::TestReturnString(CefArgs args, CefReturn retval)
{
	DKLog("DKOcrV8::TestReturnString(CefArgs,CefReturn)\n", DKINFO);

	DKString result = "test string";
	retval->SetString(0, result);
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