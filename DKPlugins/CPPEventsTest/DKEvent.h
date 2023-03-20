#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DK/DK.h"


// https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEvent : public DKObjectT<DKEvent>
{
public:
	bool Init();
	bool End();
};
REGISTER_OBJECT(DKEvent, false);


#endif //DKEvent_H