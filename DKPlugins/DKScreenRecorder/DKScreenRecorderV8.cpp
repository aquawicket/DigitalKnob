#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKScreenRecorder/DKScreenRecorder.h"
#include "DKScreenRecorder/DKScreenRecorderV8.h"

///////////////////////////////
bool DKScreenRecorderV8::Init()
{
	DKLog("DKScreenRecorderV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKScreenRecorder_TestInt", DKScreenRecorderV8::TestInt);
	DKV8::AttachFunction("DKScreenRecorder_TestString", DKScreenRecorderV8::TestString);
	DKV8::AttachFunction("DKScreenRecorder_TestReturnInt", DKScreenRecorderV8::TestReturnInt);
	DKV8::AttachFunction("DKScreenRecorder_TestReturnString", DKScreenRecorderV8::TestReturnString);
	return true;
}

//////////////////////////////
bool DKScreenRecorderV8::End()
{
	DKLog("DKScreenRecorderV8::End()\n", DKDEBUG);
	return true;
}


////////////////////////////////////////////////////////////////
bool DKScreenRecorderV8::TestInt(CefArgs args, CefReturn retval)
{
	DKLog("DKScreenRecorderV8::TestInt(CefArgs,CefReturn)\n", DKINFO);

	int data = args->GetInt(0);
	int result = data;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKScreenRecorderV8::TestString(CefArgs args, CefReturn retval)
{
	DKLog("DKScreenRecorderV8::TestString(CefArgs,CefReturn)\n", DKINFO);

	DKString data = args->GetString(0);
	DKString result = data;
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////////////
bool DKScreenRecorderV8::TestReturnInt(CefArgs args, CefReturn retval)
{
	DKLog("DKScreenRecorderV8::TestReturnInt(CefArgs,CefReturn)\n", DKINFO);

	int result = 12345;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKScreenRecorderV8::TestReturnString(CefArgs args, CefReturn retval)
{
	DKLog("DKScreenRecorderV8::TestReturnString(CefArgs,CefReturn)\n", DKINFO);

	DKString result = "test string";
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

#endif //USE_DKCef