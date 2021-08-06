#pragma once
#ifndef DKMidi_H
#define DKMidi_H

#include "RtMidi.h"
#include "DK/DK.h"

///////////////////////////////////////
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

