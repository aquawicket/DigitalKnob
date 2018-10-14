//https://github.com/uNetworking/uWebSockets/blob/master/tests/main.cpp

#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

uWS::WebSocket<true>* DKWebSockets::_ws = NULL;
uWS::Hub DKWebSockets::h;
char* DKWebSockets::_message = NULL;
size_t DKWebSockets::_length = NULL;
uWS::OpCode DKWebSockets::_opCode;

/////////////////////////
bool DKWebSockets::Init()
{
	DKClass::DKCreate("DKWebSocketsJS");
	DKClass::DKCreate("DKWebSocketsV8");

	DKApp::AppendLoopFunc(&DKWebSockets::Loop, this);
	return true;
}

////////////////////////
bool DKWebSockets::End()
{
	h.getDefaultGroup<uWS::SERVER>().close();
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseServer()
{
	h.getDefaultGroup<uWS::SERVER>().close();
	DKLog("DKWebSockets::CreateServer(): Server closed\n", DKINFO);
	return true;
}

/////////////////////////////////
bool DKWebSockets::CreateServer()
{
	h.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode){
		ProcessMessage(ws, message, length, opCode);
	});
	DKLog("DKWebSockets::CreateServer(): Server started...\n", DKINFO);
	return true;
}

/////////////////////////
void DKWebSockets::Loop()
{
	if(h.listen(3000)){
		h.poll();
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKWebSockets::ProcessMessage(uWS::WebSocket<true>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	//TODO
	DKLog("DKWebSockets::ProcessMessage("+DKString(message)+")\n", DKINFO);
	_ws = ws;
	_message = message;
	_length = length;
	_opCode = opCode;
	DKEvent::SendEvent("GLOBAL", "OnWebSocketMessage", DKString(message));
	return true;
}

///////////////////////////////////////////////////////
bool DKWebSockets::SendMessage(const DKString& message)
{
	//TODO
	DKLog("DKWebSockets::SendMessage("+message+")\n", DKDEBUG);
	DKLog("DKWebSockets::SendMessage(): _message = "+DKString(_message)+"\n", DKINFO);
	DKLog("DKWebSockets::SendMessage(): _length = "+toString(_length)+"\n", DKINFO);
	_ws->send(_message, _length, _opCode); //echo
	return true;
}