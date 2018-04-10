#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKMidi/DKMidi.h"

///////////////////
bool DKMidi::Init()
{
	DKCreate("DKMidiJS");
	DKCreate("DKMidiV8");
	
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

//////////////////
bool DKMidi::End()
{
	return true;
}



/////////////////////////////////////////////
bool DKMidi::GetInputs(DKStringArray& inputs)
{
	unsigned int nPorts = midiin->getPortCount();
	if(nPorts == 0){
		DKLog("No Input ports available!\n",DKERROR);
		return false;
	}

	inputs.clear();
	for(unsigned int i=0; i<nPorts; ++i){
		inputs.push_back(midiin->getPortName(i));
	}

	return true;
}

///////////////////////////////////////////////
bool DKMidi::GetOutputs(DKStringArray& outputs)
{
	unsigned int nPorts = midiout->getPortCount();
	if(nPorts == 0){
		DKLog("No Output ports available! \n", DKERROR);
		return false;
	}

	outputs.clear();
	for(unsigned int i=0; i<nPorts; ++i){
		outputs.push_back(midiout->getPortName(i));
	}

	return true;
}

//////////////////////////
bool DKMidi::PrintInputs()
{
	unsigned int nPorts = midiin->getPortCount();
	if(nPorts == 0){
		DKLog("No Input ports available!\n",DKERROR);
		return false;
	}
	DKLog("\nMIDI Input Ports\n", DKINFO);
	DKLog("----------------\n", DKINFO);
	for(unsigned int i=0; i<nPorts; ++i){
		DKLog(midiin->getPortName(i)+"\n", DKINFO);
	}
	DKLog("\n\n", DKINFO);
	return true;
}

///////////////////////////
bool DKMidi::PrintOutputs()
{
	unsigned int nPorts = midiout->getPortCount();
	if(nPorts == 0){
		DKLog("No Output ports available!\n",DKERROR);
		return false;
	}
	DKLog("MIDI Output Ports\n", DKINFO);
	DKLog("-----------------\n", DKINFO);
	for(unsigned int i=0; i<nPorts; ++i){
		DKLog(midiout->getPortName(i)+"\n", DKINFO);
	}
	DKLog("\n\n", DKINFO);
	return true;
}

//////////////////////////////////////////////
bool DKMidi::ToggleInput(const DKString& name)
{
	DKLog("DKMidi::ToggleInput("+name+")\n", DKDEBUG);
	
	for(unsigned int i=0; i<midiin->getPortCount(); ++i){
		if(same(name,midiin->getPortName(i))){
			midiin->openPort(i);
			DKFile::SetSetting(DKFile::local_assets+"USER/midi.txt", "[MIDIIN]", name);
			return true;
		}
	}
	return false;
}

///////////////////////////////////////////////
bool DKMidi::ToggleOutput(const DKString& name)
{
	DKLog("DKMidi::ToggleOutput("+name+")\n", DKDEBUG);
	
	for(unsigned int i=0; i<midiout->getPortCount(); ++i){
		if(same(name,midiout->getPortName(i))){
			midiout->openPort(i);
			DKFile::SetSetting(DKFile::local_assets+"USER/midi.txt", "[MIDIOUT]", name);
			return true;
		}
	}
	return false;
}


////////////////////////////////////////////////////////////////////////////////////////////////
void DKMidi::midiCallback(double deltatime, std::vector<unsigned char> *message, void *userData)
{
	/*
	unsigned int nBytes = message->size();
	for ( unsigned int i=0; i<nBytes; i++ )
		std::cout << "Byte " << i << " = " << (int)message->at(i) << ", ";
	if ( nBytes > 0 )
		std::cout << "stamp = " << deltatime << std::endl;
	*/

	if(message->size() > 2){
		DKEvent::SendEvent("GLOBAL", "midi", toString((int)message->at(0))+","+toString((int)message->at(1))+","+toString((int)message->at(2)) );
	}
	else{
		DKEvent::SendEvent("GLOBAL", "midi", toString((int)message->at(0))+","+toString((int)message->at(1))+",0");
	}
}