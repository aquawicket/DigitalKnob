#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

/////////////////////////
bool DKWebSockets::Init()
{
	//DKClass::DKCreate("DKWebSocketsJS");
	//DKClass::DKCreate("DKWebSocketsV8");

	uWS::Hub h;
	
	h.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode) {
		ws->send(message, length, opCode);
	});

	/*
	if(h.listen(3000)){
		h.run();
	}
	*/

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
		//h.run();
		h.poll();
	}
}