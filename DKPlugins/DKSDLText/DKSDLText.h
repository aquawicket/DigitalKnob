#pragma once
#ifndef DKSDLText_H
#define DKSDLText_H

#include "DK/DK.h"

/////////////////////////////////////////////
class DKSDLText : public DKObjectT<DKSDLText>
{
public:
	void Init();
	void End();
	
};

REGISTER_OBJECT(DKSDLText, true)

#endif //DKSDLText_H