#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

/////////////////////////
bool DKWebSockets::Init()
{
	//DKClass::DKCreate("DKWebSocketsJS");
	//DKClass::DKCreate("DKWebSocketsV8");

	h.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode) {
		ws->send(message, length, opCode);
	});

	DKApp::AppendLoopFunc(&DKWebSockets::Loop, this);
	return true;
}

////////////////////////
bool DKWebSockets::End()
{
	return true;
}

/////////////////////////
void DKWebSockets::Loop()
{
	if(h.listen(3000)){
		h.poll();
	}
}