#ifdef USE_DKDuktape 
#include "DKTray.h"
#include "DKTrayJS.h"


/////////////////////
void DKTrayJS::Init()
{
	DKDuktape::AttachFunction("DKTray_GetIcon", DKTrayJS::GetIcon, 0);
	DKDuktape::AttachFunction("DKTray_SetIcon", DKTrayJS::SetIcon, 1);
	//DKDuktape::AttachFunction("DKMidi_GetMidiInputs", DKTrayJS::GetMidiInputs, 0);
	//DKDuktape::AttachFunction("DKMidi_GetMidiOutputs", DKTrayJS::GetMidiOutputs, 0);
	//DKDuktape::AttachFunction("DKMidi_ToggleMidiInput", DKTrayJS::ToggleMidiInput, 1);
	//DKDuktape::AttachFunction("DKMidi_ToggleMidiOutput", DKTrayJS::ToggleMidiOutput, 1);
	//DKDuktape::AttachFunction("DKMidi_SendMidi", DKTrayJS::SendMidi, 3);
}

////////////////////////////////
int DKTrayJS::GetIcon(duk_context* ctx)
{
	DKString icon = DKTray::Get("DKTray0")->GetIcon();
	duk_push_string(ctx, icon.c_str());
	return 1;
}

///////////////////////////////
int DKTrayJS::SetIcon(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	DKTray::Get("DKTray0")->SetIcon(file);
	return 1;
}

/*
//////////////////////////////////////
int DKTrayJS::GetMidiInputs(duk_context* ctx)
{
	DKMidi::Instance("DKMidi");
	DKStringArray inputs;
	DKMidi::Instance("DKMidi")->GetInputs(inputs);
	DKString final = toString(inputs);
	duk_push_string(ctx, final.c_str());
	return 1;
}

///////////////////////////////////////
int DKTrayJS::GetMidiOutputs(duk_context* ctx)
{
	DKMidi::Instance("DKMidi");
	DKStringArray outputs;
	DKMidi::Instance("DKMidi")->GetOutputs(outputs);
	DKString final = toString(outputs);
	duk_push_string(ctx, final.c_str());
	return 1;
}

////////////////////////////////////////
int DKTrayJS::ToggleMidiInput(duk_context* ctx)
{
	DKString input = duk_require_string(ctx, 0);
	if(DKMidi::Instance("DKMidi")->ToggleInput(input)){
		return 1;
	}
	return 0;
}

/////////////////////////////////////////
int DKTrayJS::ToggleMidiOutput(duk_context* ctx)
{
	DKString output = duk_require_string(ctx, 0);
	if(DKMidi::Instance("DKMidi")->ToggleOutput(output)){
		return 1;
	}
	return 0;
}

/////////////////////////////////
int DKTrayJS::SendMidi(duk_context* ctx)
{
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
*/

#endif //USE_DKDuktape