/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#ifdef HAVE_rtmidi
#ifdef HAVE_DKDuktape

#include "DKMidi/DKMidi.h"
#include "DKMidi/DKMidiJS.h"


bool DKMidiJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKMidi_GetMidiInputs", DKMidiJS::GetMidiInputs);
	DKDuktape::AttachFunction("CPP_DKMidi_GetMidiOutputs", DKMidiJS::GetMidiOutputs);
	DKDuktape::AttachFunction("CPP_DKMidi_SendMidi", DKMidiJS::SendMidi);
	DKDuktape::AttachFunction("CPP_DKMidi_ToggleMidiInput", DKMidiJS::ToggleMidiInput);
	DKDuktape::AttachFunction("CPP_DKMidi_ToggleMidiOutput", DKMidiJS::ToggleMidiOutput);
	return true;
}

int DKMidiJS::GetMidiInputs(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKMidi::Instance("DKMidi");
	DKStringArray inputs;
	DKMidi::Instance("DKMidi")->GetInputs(inputs);
	DKString final = toString(inputs,",");
	duk_push_string(ctx, final.c_str());
	return true;
}

int DKMidiJS::GetMidiOutputs(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKMidi::Instance("DKMidi");
	DKStringArray outputs;
	DKMidi::Instance("DKMidi")->GetOutputs(outputs);
	DKString final = toString(outputs,",");
	duk_push_string(ctx, final.c_str());
	return true;
}

int DKMidiJS::SendMidi(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	unsigned char var1 = (unsigned char)duk_require_int(ctx, 0);
	unsigned char var2 = (unsigned char)duk_require_int(ctx, 1);
	unsigned char var3 = (unsigned char)duk_require_int(ctx, 2);
	std::vector<unsigned char> message;
	message.push_back(var1);
	message.push_back(var2);
	message.push_back(var3);
	DKMidi::Instance("DKMidi")->midiout->sendMessage(&message);
	return true;
}

int DKMidiJS::ToggleMidiInput(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	if(!DKMidi::Instance("DKMidi")->ToggleInput(input))
		return false;
	return true;
}

int DKMidiJS::ToggleMidiOutput(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString output = duk_require_string(ctx, 0);
	if(!DKMidi::Instance("DKMidi")->ToggleOutput(output))
		return false;
	return true;
}

#endif //HAVE_DKDuktape
#endif //HAVE_rtmidi