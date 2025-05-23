/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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

#if HAVE_rtmidi
#pragma once
#ifndef DKMidi_H
#define DKMidi_H

//WARNING_DISABLE
#include "RtMidi.h"
//WARNING_ENABLE

#include "DK/DK.h"


class DKMidi : public DKObjectT<DKMidi>
{
public:
	bool Init();
	bool End();

	bool GetInputs(DKStringArray& inputs);
	bool GetOutputs(DKStringArray& outputs);
	bool PrintInputs();
	bool PrintOutputs();
	bool ToggleInput(const DKString& name);
	bool ToggleOutput(const DKString& name);

	static void midiCallback(double deltatime, std::vector<unsigned char> *message, void *userData);
	
	RtMidiIn *midiin;
	RtMidiOut *midiout;
};


REGISTER_OBJECT(DKMidi, true);

#endif //DKMidi_H

#endif //HAVE_rtmidi