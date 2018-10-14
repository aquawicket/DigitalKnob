#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKCurl/DKCurl.h"
#include "DKCurl/DKCurlV8.h"

/////////////////////
bool DKCurlV8::Init()
{
	DKLog("DKCurlV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKCurl_GetMidiInputs", DKCurlV8::GetMidiInputs);

	return true;
}

////////////////////
bool DKCurlV8::End()
{
	DKLog("DKCurlV8::End()\n", DKDEBUG);
	return true;
}

/*
////////////////////////////////////////////////////////////
bool DKCurlV8::GetMidiInputs(CefArgs args, CefReturn retval)
{
	DKCurl::Instance("DKCurl");
	DKStringArray inputs;
	DKCurl::Instance("DKCurl")->GetInputs(inputs);
	DKString final = toString(inputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCurlV8::GetMidiOutputs(CefArgs args, CefReturn retval)
{
	DKCurl::Instance("DKCurl");
	DKStringArray outputs;
	DKCurl::Instance("DKCurl")->GetOutputs(outputs);
	DKString final = toString(outputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKCurlV8::SendMidi(CefArgs args, CefReturn retval)
{
	int var1 = args->GetInt(0);
	int var2 = args->GetInt(1);
	int var3 = args->GetInt(2);

	std::vector<unsigned char> message;
	message.push_back(var1);
	message.push_back(var2);
	message.push_back(var3);
	DKCurl::Instance("DKCurl")->midiout->sendMessage(&message);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKCurlV8::ToggleMidiInput(CefArgs args, CefReturn retval)
{
	DKString input = args->GetString(0);
	if(!DKCurl::Instance("DKCurl")->ToggleInput(input)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////
bool DKCurlV8::ToggleMidiOutput(CefArgs args, CefReturn retval)
{
	DKString output = args->GetString(0);
	if(!DKCurl::Instance("DKCurl")->ToggleOutput(output)){ return false; }
	return true;
}
*/

#endif //USE_DKCef