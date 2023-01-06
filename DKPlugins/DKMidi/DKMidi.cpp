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

#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKMidi/DKMidi.h"


bool DKMidi::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKMidiJS");
	DKClass::DKCreate("DKMidiV8");
	midiin = new RtMidiIn();
	midiout = new RtMidiOut();
	DKString inputs;
	DKFile::GetSetting(DKFile::local_assets+"USER/midi.txt", "[MIDIIN]", inputs);
	ToggleInput(inputs);
	DKString outputs;
	DKFile::GetSetting(DKFile::local_assets+"USER/midi.txt", "[MIDIOUT]", outputs);
	ToggleOutput(outputs);
	midiin->setCallback(&DKMidi::midiCallback,(void *)this);
	return true;
}

bool DKMidi::End(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKMidiJS");
	DKClass::DKCreate("DKMidiV8");
	return true;
}

bool DKMidi::GetInputs(DKStringArray& inputs){
	DKDEBUGFUNC("DKStringArray&");
	unsigned int nPorts = midiin->getPortCount();
	if(nPorts == 0)
		return DKERROR("No Input ports available!\n");
	inputs.clear();
	for(unsigned int i=0; i<nPorts; ++i){
		inputs.push_back(midiin->getPortName(i));
	}
	return true;
}

bool DKMidi::GetOutputs(DKStringArray& outputs){
	DKDEBUGFUNC("DKStringArray&");
	unsigned int nPorts = midiout->getPortCount();
	if(nPorts == 0)
		return DKERROR("No Output ports available\n");
	outputs.clear();
	for(unsigned int i=0; i<nPorts; ++i){
		outputs.push_back(midiout->getPortName(i));
	}
	return true;
}

bool DKMidi::PrintInputs(){
	DKDEBUGFUNC();
	unsigned int nPorts = midiin->getPortCount();
	if(nPorts == 0)
		return DKERROR("No Input ports available\n");
	DKINFO("\nMIDI Input Ports\n");
	DKINFO("----------------\n");
	for(unsigned int i=0; i<nPorts; ++i){
		DKINFO(midiin->getPortName(i)+"\n");
	}
	DKINFO("\n\n");
	return true;
}

bool DKMidi::PrintOutputs(){
	DKDEBUGFUNC();
	unsigned int nPorts = midiout->getPortCount();
	if(nPorts == 0)
		return DKERROR("No Output ports available\n");
	DKINFO("MIDI Output Ports\n");
	DKINFO("-----------------\n");
	for(unsigned int i=0; i<nPorts; ++i){
		DKINFO(midiout->getPortName(i)+"\n");
	}
	DKINFO("\n\n");
	return true;
}

bool DKMidi::ToggleInput(const DKString& name){
	DKDEBUGFUNC(name);
	for(unsigned int i=0; i<midiin->getPortCount(); ++i){
		if(same(name,midiin->getPortName(i))){
			midiin->openPort(i);
			DKFile::SetSetting(DKFile::local_assets+"USER/midi.txt", "[MIDIIN]", name);
			return true;
		}
	}
	return false;
}

bool DKMidi::ToggleOutput(const DKString& name){
	DKDEBUGFUNC(name);
	for(unsigned int i=0; i<midiout->getPortCount(); ++i){
		if(same(name,midiout->getPortName(i))){
			midiout->openPort(i);
			DKFile::SetSetting(DKFile::local_assets+"USER/midi.txt", "[MIDIOUT]", name);
			return true;
		}
	}
	return false;
}

void DKMidi::midiCallback(double deltatime, std::vector<unsigned char>* message, void *userData){
	DKDEBUGFUNC(deltatime, message, userData);
	/*
	unsigned int nBytes = message->size();
	for ( unsigned int i=0; i<nBytes; i++ )
		std::cout << "Byte " << i << " = " << (int)message->at(i) << ", ";
	if ( nBytes > 0 )
		std::cout << "stamp = " << deltatime << std::endl;
	*/
	if(message->size() > 2){
		DKEvents::SendEvent("window", "midi", toString((int)message->at(0))+","+toString((int)message->at(1))+","+toString((int)message->at(2)) );
	}
	else{
		DKEvents::SendEvent("window", "midi", toString((int)message->at(0))+","+toString((int)message->at(1))+",0");
	}
}

#endif //HAVE_rtmidi