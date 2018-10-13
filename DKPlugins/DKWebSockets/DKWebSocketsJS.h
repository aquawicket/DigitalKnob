#ifdef USE_DKDuktape 
#pragma once
#ifndef DKWebSocketsJS_H
#define DKWebSocketsJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////
class DKWebSocketsJS : public DKObjectT<DKWebSocketsJS>
{
public:
	bool Init();

};

REGISTER_OBJECT(DKWebSocketsJS, true)

#endif //DKWebSocketsJS_H
#endif //USE_DKDuktape