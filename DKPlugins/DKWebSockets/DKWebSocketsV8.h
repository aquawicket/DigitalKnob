#ifdef USE_DKCef
#pragma once
#ifndef DKWebSocketsV8_H
#define DKWebSocketsV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////
class DKWebSocketsV8 : public DKObjectT<DKWebSocketsV8>
{
public:
	bool Init();
	bool End();
};

REGISTER_OBJECT(DKWebSocketsV8, false);

#endif //DKWebSocketsV8_H
#endif //USE_DKCef