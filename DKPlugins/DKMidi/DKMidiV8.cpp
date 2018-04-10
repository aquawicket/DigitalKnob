#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKMidi/DKMidi.h"
#include "DKMidi/DKMidiV8.h"

/////////////////////
bool DKMidiV8::Init()
{
	DKLog("DKMidiV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKMidi_TestInt", DKMidiV8::TestInt);
	DKV8::AttachFunction("DKMidi_TestString", DKMidiV8::TestString);
	DKV8::AttachFunction("DKMidi_TestReturnInt", DKMidiV8::TestReturnInt);
	DKV8::AttachFunction("DKMidi_TestReturnString", DKMidiV8::TestReturnString);
	return true;
}

//////////////////////
bool DKMidiV8::End()
{
	DKLog("DKMidiV8::End()\n", DKDEBUG);
	return true;
}


////////////////////////////////////////////////////////
bool DKMidiV8::TestInt(CefArgs args, CefReturn retval)
{
	DKLog("DKMidiV8::TestInt(CefArgs,CefReturn)\n", DKINFO);

	int data = args->GetInt(0);
	int result = data;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKMidiV8::TestString(CefArgs args, CefReturn retval)
{
	DKLog("DKMidiV8::TestString(CefArgs,CefReturn)\n", DKINFO);

	DKString data = args->GetString(0);
	DKString result = data;
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKMidiV8::TestReturnInt(CefArgs args, CefReturn retval)
{
	DKLog("DKMidiV8::TestReturnInt(CefArgs,CefReturn)\n", DKINFO);

	int result = 12345;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKMidiV8::TestReturnString(CefArgs args, CefReturn retval)
{
	DKLog("DKMidiV8::TestReturnString(CefArgs,CefReturn)\n", DKINFO);

	DKString result = "test string";
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

#endif //USE_DKCef