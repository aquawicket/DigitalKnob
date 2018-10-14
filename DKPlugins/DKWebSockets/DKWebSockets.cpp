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
	DKLog("DKWebSockets::ProcessMessage("+DKString(message)+","+toString(length)+")\n", DKDEBUG);
	_ws = ws;
	_message = message;
	_length = length;
	_opCode = opCode;
	DKLog("DKWebSockets::ProcessMessage(): _message = "+DKString(_message)+"\n", DKINFO);
	DKLog("DKWebSockets::ProcessMessage(): _length = "+toString(_length)+"\n", DKINFO);
	DKString message_  = DKString(_message).substr(0,_length);
	DKEvent::SendEvent("GLOBAL", "DKWebSockets_OnMessage", message_);
	return true;
}

///////////////////////////////////////////////////////
bool DKWebSockets::SendMessage(const DKString& message)
{
	DKLog("DKWebSockets::SendMessage("+message+")\n", DKINFO);//, DKDEBUG);

	DKString message_ = toString(_message);
	message_ = message_.substr(_length, message_.length()); //strip the message
	DKLog("DKWebSockets::SendMessage(): message_ = "+message_+"\n", DKINFO);
	message_ = message+message_;
	size_t length_ = _length;
	uWS::OpCode opCode_ = _opCode;

	DKLog("DKWebSockets::SendMessage(): message_ = "+DKString(message_)+"\n", DKINFO);
	DKLog("DKWebSockets::SendMessage(): length_ = "+toString(length_)+"\n", DKINFO);
	_ws->send(message_.c_str(), length_, opCode_);
	return true;
}