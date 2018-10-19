#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKMidi/DKMidi.h"
#include "DKMidi/DKMidiV8.h"

/////////////////////
bool DKMidiV8::Init()
{
	DKDebug();
	DKV8::AttachFunction("DKMidi_GetMidiInputs", DKMidiV8::GetMidiInputs);
	DKV8::AttachFunction("DKMidi_GetMidiOutputs", DKMidiV8::GetMidiOutputs);
	DKV8::AttachFunction("DKMidi_SendMidi", DKMidiV8::SendMidi);
	DKV8::AttachFunction("DKMidi_ToggleMidiInput", DKMidiV8::ToggleMidiInput);
	DKV8::AttachFunction("DKMidi_ToggleMidiOutput", DKMidiV8::ToggleMidiOutput);
	return true;
}

////////////////////
bool DKMidiV8::End()
{
	DKDebug();
	return true;
}


////////////////////////////////////////////////////////////
bool DKMidiV8::GetMidiInputs(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKMidi::Instance("DKMidi");
	DKStringArray inputs;
	DKMidi::Instance("DKMidi")->GetInputs(inputs);
	DKString final = toString(inputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKMidiV8::GetMidiOutputs(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKMidi::Instance("DKMidi");
	DKStringArray outputs;
	DKMidi::Instance("DKMidi")->GetOutputs(outputs);
	DKString final = toString(outputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKMidiV8::SendMidi(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int var1 = args->GetInt(0);
	int var2 = args->GetInt(1);
	int var3 = args->GetInt(2);

	std::vector<unsigned char> message;
	message.push_back(var1);
	message.push_back(var2);
	message.push_back(var3);
	DKMidi::Instance("DKMidi")->midiout->sendMessage(&message);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKMidiV8::ToggleMidiInput(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString input = args->GetString(0);
	if(!DKMidi::Instance("DKMidi")->ToggleInput(input)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////
bool DKMidiV8::ToggleMidiOutput(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString output = args->GetString(0);
	if(!DKMidi::Instance("DKMidi")->ToggleOutput(output)){ return false; }
	return true;
}

#endif //USE_DKCef