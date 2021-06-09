#pragma once
#ifndef DKDomWindowEventHandlers_H
#define DKDomWindowEventHandlers_H

#include "DKDuktape/DKDuktape.h"


class DKDomWindowEventHandlers : public DKObjectT<DKDomWindowEventHandlers>
{
public:
	bool Init();

};


REGISTER_OBJECT(DKDomWindowEventHandlers, true)

#endif //DKDomWindowEventHandlers_H