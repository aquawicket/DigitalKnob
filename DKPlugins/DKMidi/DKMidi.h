#pragma once
#ifndef DKMidi_H
#define DKMidi_H

#include "RtMidi.h"
#include "DK/DK.h"

///////////////////////////////////////
class DKMidi : public DKObjectT<DKMidi>
{
public:
	void Init();
	void End();

	bool GetInputs(DKStringArray& inputs);
	bool GetOutputs(DKStringArray& outputs);
	bool ToggleInput(const DKString& name);
	bool ToggleOutput(const DKString& name);

	RtMidiIn *midiin;
	RtMidiOut *midiout;

private:
	bool PrintInputs();
	bool PrintOutputs();
	static void midiCallback(double deltatime, std::vector<unsigned char> *message, void *userData);
};


REGISTER_OBJECT(DKMidi, true);

#endif //DKMidi_H

