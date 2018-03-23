#pragma once
#ifndef DKCrypto_H
#define DKCrypto_H

#include "DK/DK.h"

///////////////////////////////////////////
class DKCrypto : public DKObjectT<DKCrypto>
{
public:
	bool Init();
	bool End();
};


REGISTER_OBJECT(DKCrypto, true);

#endif //DKCrypto_H

