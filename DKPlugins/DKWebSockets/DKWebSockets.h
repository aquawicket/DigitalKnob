#pragma once
#ifndef DKWebSockets_H
#define DKWebSockets_H

//#include "libwebsockets.h"
#include "src/uWS.h"
#include "DK/DK.h"

///////////////////////////////////////////////////
class DKWebSockets : public DKObjectT<DKWebSockets>
{
public:
	bool Init();
	bool End();
	void Loop();

	static bool ProcessMessage(uWS::WebSocket<true>* ws, char *message, size_t length, uWS::OpCode opCode);
	static bool SendMessage(const DKString& message);
	uWS::Hub h;
};


REGISTER_OBJECT(DKWebSockets, true);

#endif //DKWebSockets_H

