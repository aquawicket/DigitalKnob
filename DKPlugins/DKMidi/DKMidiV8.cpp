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
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#ifdef HAVE_rtmidi
#ifdef HAVE_DKCef

#include "DK/DKApp.h"
#include "DKMidi/DKMidi.h"
#include "DKMidi/DKMidiV8.h"


bool DKMidiV8::Init(){
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKMidi_GetMidiInputs", DKMidiV8::GetMidiInputs);
	DKV8::AttachFunction("DKMidi_GetMidiOutputs", DKMidiV8::GetMidiOutputs);
	DKV8::AttachFunction("DKMidi_SendMidi", DKMidiV8::SendMidi);
	DKV8::AttachFunction("DKMidi_ToggleMidiInput", DKMidiV8::ToggleMidiInput);
	DKV8::AttachFunction("DKMidi_ToggleMidiOutput", DKMidiV8::ToggleMidiOutput);
	return true;
}

bool DKMidiV8::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKMidiV8::GetMidiInputs(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKMidi::Instance("DKMidi");
	DKStringArray inputs;
	DKMidi::Instance("DKMidi")->GetInputs(inputs);
	DKString final = toString(inputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

bool DKMidiV8::GetMidiOutputs(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKMidi::Instance("DKMidi");
	DKStringArray outputs;
	DKMidi::Instance("DKMidi")->GetOutputs(outputs);
	DKString final = toString(outputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

bool DKMidiV8::SendMidi(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned char var1 = (unsigned char)args->GetInt(0);
	unsigned char var2 = (unsigned char)args->GetInt(1);
	unsigned char var3 = (unsigned char)args->GetInt(2);
	std::vector<unsigned char> message;
	message.push_back(var1);
	message.push_back(var2);
	message.push_back(var3);
	DKMidi::Instance("DKMidi")->midiout->sendMessage(&message);
	return true;
}

bool DKMidiV8::ToggleMidiInput(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString input = args->GetString(0);
	if(!DKMidi::Instance("DKMidi")->ToggleInput(input)){ return false; }
	return true;
}

bool DKMidiV8::ToggleMidiOutput(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString output = args->GetString(0);
	if(!DKMidi::Instance("DKMidi")->ToggleOutput(output)){ return false; }
	return true;
}

#endif //HAVE_DKCef
#endif //HAVE_rtmidi
