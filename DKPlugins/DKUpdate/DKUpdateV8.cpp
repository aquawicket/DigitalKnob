#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKUpdate/DKUpdate.h"
#include "DKUpdate/DKUpdateV8.h"

/////////////////////
bool DKUpdateV8::Init()
{
	DKLog("DKUpdateV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKUpdate_GetMidiInputs", DKUpdateV8::GetMidiInputs);
	return true;
}

////////////////////
bool DKUpdateV8::End()
{
	DKLog("DKUpdateV8::End()\n", DKDEBUG);
	return true;
}

/*
////////////////////////////////////////////////////////////
bool DKUpdateV8::GetMidiInputs(CefArgs args, CefReturn retval)
{
	DKUpdate::Instance("DKUpdate");
	DKStringArray inputs;
	DKUpdate::Instance("DKUpdate")->GetInputs(inputs);
	DKString final = toString(inputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKUpdateV8::GetMidiOutputs(CefArgs args, CefReturn retval)
{
	DKUpdate::Instance("DKUpdate");
	DKStringArray outputs;
	DKUpdate::Instance("DKUpdate")->GetOutputs(outputs);
	DKString final = toString(outputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKUpdateV8::SendMidi(CefArgs args, CefReturn retval)
{
	int var1 = args->GetInt(0);
	int var2 = args->GetInt(1);
	int var3 = args->GetInt(2);

	std::vector<unsigned char> message;
	message.push_back(var1);
	message.push_back(var2);
	message.push_back(var3);
	DKUpdate::Instance("DKUpdate")->midiout->sendMessage(&message);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKUpdateV8::ToggleMidiInput(CefArgs args, CefReturn retval)
{
	DKString input = args->GetString(0);
	if(!DKUpdate::Instance("DKUpdate")->ToggleInput(input)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////
bool DKUpdateV8::ToggleMidiOutput(CefArgs args, CefReturn retval)
{
	DKString output = args->GetString(0);
	if(!DKUpdate::Instance("DKUpdate")->ToggleOutput(output)){ return false; }
	return true;
}
*/

#endif //USE_DKCef