#ifdef USE_DKDuktape 
#pragma once
#ifndef DKThreadJS_H
#define DKThreadJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////
class DKThreadJS : public DKObjectT<DKThreadJS>
{
public:
	bool Init();
	
	static int GetThreadNames(duk_context* ctx);
	static int _DKQueue(duk_context* ctx);
	static void QueueItem();

};

REGISTER_OBJECT(DKThreadJS, true)

#endif //DKDKThreadJS_H
#endif //USE_DKThread