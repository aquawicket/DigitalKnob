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

	static int CloseClient(duk_context* ctx);
	static int CloseServer(duk_context* ctx);
	static int CreateClient(duk_context* ctx);
	static int CreateServer(duk_context* ctx);
	static int SendMessage(duk_context* ctx);
};

REGISTER_OBJECT(DKWebSocketsJS, true)

#endif //DKWebSocketsJS_H
#endif //USE_DKDuktape