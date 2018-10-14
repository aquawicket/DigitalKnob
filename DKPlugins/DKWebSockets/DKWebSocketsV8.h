#ifdef USE_DKCef
#pragma once
#ifndef DKWebSocketsV8_H
#define DKWebSocketsV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////////////
class DKWebSocketsV8 : public DKObjectT<DKWebSocketsV8>
{
public:
	bool Init();
	bool End();

	static bool CloseClient(CefArgs args, CefReturn retval);
	static bool CloseServer(CefArgs args, CefReturn retval);
	static bool CreateClient(CefArgs args, CefReturn retval);
	static bool CreateServer(CefArgs args, CefReturn retval);
	static bool MessageToClient(CefArgs args, CefReturn retval);
	static bool MessageToServer(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKWebSocketsV8, false);

#endif //DKWebSocketsV8_H
#endif //USE_DKCef