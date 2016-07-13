#ifdef USE_DKDuktape 
#pragma once
#ifndef DKTrayJS_H
#define DKTrayJS_H

#include "DKDuktape.h"

///////////////////////////////////////////
class DKTrayJS : public DKObjectT<DKTrayJS>
{
public:
	void Init();
	//static int GetMidiInputs(duk_context* ctx);
	//static int GetMidiOutputs(duk_context* ctx);
	//static int ToggleMidiInput(duk_context* ctx);
	//static int ToggleMidiOutput(duk_context* ctx);
	//static int SendMidi(duk_context* ctx);
	static int GetIcon(duk_context* ctx);
	static int SetIcon(duk_context* ctx);
};

REGISTER_OBJECT(DKTrayJS, true)

#endif //DKTrayJS_H
#endif //USE_DKDuktape