#ifdef USE_DKDuktape 
#pragma once
#ifndef DKMidiJS_H
#define DKMidiJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////
class DKMidiJS : public DKObjectT<DKMidiJS>
{
public:
	bool Init();
	
	static int GetMidiInputs(duk_context* ctx);
	static int GetMidiOutputs(duk_context* ctx);
	static int SendMidi(duk_context* ctx);
	static int ToggleMidiInput(duk_context* ctx);
	static int ToggleMidiOutput(duk_context* ctx);
};

REGISTER_OBJECT(DKMidiJS, true)

#endif //DKMidiJS_H
#endif //USE_DKDuktape