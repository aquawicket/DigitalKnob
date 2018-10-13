//https://github.com/uNetworking/uWebSockets/blob/master/tests/main.cpp

#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

uWS::WebSocket<true>* DKWebSockets::_ws;
uWS::Hub DKWebSockets::h;
char* DKWebSockets::_message;
size_t DKWebSockets::_length;
uWS::OpCode DKWebSockets::_opCode;

/////////////////////////
bool DKWebSockets::Init()
{
	DKClass::DKCreate("DKWebSocketsJS");
	DKClass::DKCreate("DKWebSocketsV8");

	h.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode){
		ProcessMessage(ws, message, length, opCode);
		//ws->send(message, length, opCode); //echo
	});

	DKApp::AppendLoopFunc(&DKWebSockets::Loop, this);
	return true;
}

////////////////////////
bool DKWebSockets::End()
{
	h.getDefaultGroup<uWS::SERVER>().close();
	return true;
}

/////////////////////////
void DKWebSockets::Loop()
{
	if(h.listen(3000)){
		h.poll();
	}

	// Test sending..   fails
	/*
	long ticks;
	DKUtil::GetTicks(ticks);
	DKLog("DKUtil::GetTicks() = "+toString(ticks)+"\n", DKINFO);
	if(ticks > 26169041){
		SendMessage("test");
	}
	*/
}

//////////////////////////////////////////////////////////////////////////
bool DKWebSockets::ProcessMessage(uWS::WebSocket<true>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	//TODO
	DKLog("DKWebSockets::ProcessMessage("+DKString(message)+")\n", DKINFO);
	_ws = ws;
	_message = message;
	_length = length;
	_opCode = opCode;
	//ws->send(message, length, opCode); //echo
	return false;
}

///////////////////////////////////////////////////////
bool DKWebSockets::SendMessage(const DKString& message)
{
	//TODO
	DKLog("DKWebSockets::SendMessage("+message+")\n", DKINFO);
	_ws->send(_message, _length, _opCode); //echo
	return false;
}