#pragma once
#ifndef DKDuktapeDom_H
#define DKDuktapeDom_H


#include "DKDuktape/DKDuktape.h"


class DKDuktapeDom : public DKObjectT<DKDuktapeDom>
{
public:
	bool Init();
	
};

REGISTER_OBJECT(DKDuktapeDom, true)

#endif //DKDuktapeDom_H