#pragma once
#ifndef DKOcr_H
#define DKOcr_H

#include "RtMidi.h"
#include "DK/DK.h"

//////////////////////////////////////
class DKOcr : public DKObjectT<DKOcr>
{
public:
	void Init();
	void End();

};


REGISTER_OBJECT(DKOcr, true);

#endif //DKOcr_H

