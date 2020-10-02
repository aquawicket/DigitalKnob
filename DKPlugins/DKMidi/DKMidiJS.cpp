#ifdef USE_DKDuktape 
#include "DKMidi.h"
#include "DKMidiJS.h"


/////////////////////
bool DKMidiJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKMidi_GetMidiInputs", DKMidiJS::GetMidiInputs);
	DKDuktape::AttachFunction("DKCPP_DKMidi_GetMidiOutputs", DKMidiJS::GetMidiOutputs);
	DKDuktape::AttachFunction("DKCPP_DKMidi_SendMidi", DKMidiJS::SendMidi);
	DKDuktape::AttachFunction("DKCPP_DKMidi_ToggleMidiInput", DKMidiJS::ToggleMidiInput);
	DKDuktape::AttachFunction("DKCPP_DKMidi_ToggleMidiOutput", DKMidiJS::ToggleMidiOutput);
	return true;
}

/////////////////////////////////////////////
int DKMidiJS::GetMidiInputs(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKMidi::Instance("DKMidi");
	DKStringArray inputs;
	DKMidi::Instance("DKMidi")->GetInputs(inputs);
	DKString final = toString(inputs,",");
	duk_push_string(ctx, final.c_str());
	return 1;
}

//////////////////////////////////////////////
int DKMidiJS::GetMidiOutputs(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKMidi::Instance("DKMidi");
	DKStringArray outputs;
	DKMidi::Instance("DKMidi")->GetOutputs(outputs);
	DKString final = toString(outputs,",");
	duk_push_string(ctx, final.c_str());
	return 1;
}

////////////////////////////////////////
int DKMidiJS::SendMidi(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int var1 = duk_require_int(ctx, 0);
	int var2 = duk_require_int(ctx, 1);
	int var3 = duk_require_int(ctx, 2);

	std::vector<unsigned char> message;
	message.push_back(var1);
	message.push_back(var2);
	message.push_back(var3);
	DKMidi::Instance("DKMidi")->midiout->sendMessage(&message);
	return 1;
}

///////////////////////////////////////////////
int DKMidiJS::ToggleMidiInput(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	if(!DKMidi::Instance("DKMidi")->ToggleInput(input)){ return 0; }
	return 1;
}

////////////////////////////////////////////////
int DKMidiJS::ToggleMidiOutput(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString output = duk_require_string(ctx, 0);
	if(!DKMidi::Instance("DKMidi")->ToggleOutput(output)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape