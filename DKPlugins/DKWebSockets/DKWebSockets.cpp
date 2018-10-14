//https://github.com/uNetworking/uWebSockets/blob/master/tests/main.cpp

#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

DKString DKWebSockets::_address;
int DKWebSockets::_port = NULL;
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
	DKLog("DKWebSockets::CreateServer()\n", DKDEBUG);
	h.getDefaultGroup<uWS::SERVER>().close();
	_port = NULL;
	_ws = NULL;
	_message = NULL;
	_length = NULL;
	DKLog("DKWebSockets::CreateServer(): Server closed\n", DKINFO);
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKWebSockets::CreateServer(const DKString& address, const int& port)
{
	_address = address;
	_port = port;
	DKLog("DKWebSockets::CreateServer("+address+","+toString(port)+")\n", DKINFO);

	h.onError([](void *user){
		switch ((long) user){
		case 1:
			DKLog("Client emitted error on invalid URI\n", DKERROR);
			break;
		case 2:
			DKLog("Client emitted error on resolve failure\n", DKERROR);
			break;
		case 3:
			DKLog("Client emitted error on connection timeout (non-SSL)\n", DKERROR);
			break;
		case 5:
			DKLog("Client emitted error on connection timeout (SSL)\n", DKERROR);
			break;
		case 6:
			DKLog("Client emitted error on HTTP response without upgrade (non-SSL)\n", DKERROR);
			break;
		case 7:
			DKLog("Client emitted error on HTTP response without upgrade (SSL)\n", DKERROR);
			break;
		case 10:
			DKLog("Client emitted error on poll error\n", DKERROR);
			break;
		case 11:
			static int protocolErrorCount = 0;
			protocolErrorCount++;
			DKLog("Client emitted error on invalid protocol\n", DKERROR);
			if (protocolErrorCount > 1) {
				DKLog("FAILURE: "+toString(protocolErrorCount)+" errors emitted for one connection!\n", DKERROR);
				exit(-1);
			}
			break;
		//default:
			//std::cout << "FAILURE: " << user << " should not emit error!" << std::endl;
			//exit(-1);
		}
	});

	h.onConnection([](uWS::WebSocket<uWS::SERVER> *ws, uWS::HttpRequest req){
		switch ((long) ws->getUserData()) {
		case 8:
			DKLog("Client established a remote connection over non-SSL", DKINFO);
			break;
		case 9:
			DKLog("Client established a remote connection over SSL", DKINFO);
			break;
		default:
			DKLog("FAILURE: ws->getUserData() should not connect!", DKINFO);
		}
	});

	h.onDisconnection([](uWS::WebSocket<uWS::SERVER> *ws, int code, char *message, size_t length) {
		DKLog("Client got disconnected with data:ws->getUserData(), code:"+toString(code)+", message:<"+DKString(message, length)+">\n", DKINFO);
	});

	h.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode){
		ProcessMessage(ws, message, length, opCode);
	});

	DKLog("DKWebSockets::CreateServer(): Server started...\n", DKINFO);
	return true;
}

/////////////////////////
void DKWebSockets::Loop()
{
	if(!_address.empty() && _port && h.listen(_address, _port)){
		h.poll();
	}
	if(_address.empty() && _port && h.listen(_port)){
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
	//DKLog("DKWebSockets::ProcessMessage(): _message = "+DKString(_message)+"\n", DKINFO);
	//DKLog("DKWebSockets::ProcessMessage(): _length = "+toString(_length)+"\n", DKINFO);
	DKString message_  = DKString(_message).substr(0,_length);
	//DKLog("DKWebSockets::ProcessMessage(): message_ = "+DKString(message_)+"\n", DKINFO);
	DKEvent::SendEvent("GLOBAL", "DKWebSockets_OnMessage", message_);
	return true;
}

///////////////////////////////////////////////////////
bool DKWebSockets::SendMessage(const DKString& message)
{
	DKLog("DKWebSockets::SendMessage("+message+")\n", DKINFO);//, DKDEBUG);

	DKString message_ = toString(_message);
	message_ = message_.substr(_length, message_.length()); //strip the message
	//DKLog("DKWebSockets::SendMessage(): message_ = "+message_+"\n", DKINFO);
	message_ = message+message_;
	size_t length_ = message.length();
	uWS::OpCode opCode_ = _opCode;

	//DKLog("DKWebSockets::SendMessage(): message_ = "+DKString(message_)+"\n", DKINFO);
	//DKLog("DKWebSockets::SendMessage(): length_ = "+toString(length_)+"\n", DKINFO);
	_ws->send(message_.c_str(), length_, opCode_);
	return true;
}