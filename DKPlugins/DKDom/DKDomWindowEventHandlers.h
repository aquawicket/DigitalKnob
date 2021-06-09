#pragma once
#ifndef WindowEventHandlers_H
#define WindowEventHandlers_H

#include "DKDuktape/DKDuktape.h"


class WindowEventHandlers : public DKObjectT<WindowEventHandlers>
{
public:
	bool Init();

};


REGISTER_OBJECT(WindowEventHandlers, true)

#endif //WindowEventHandlers_H