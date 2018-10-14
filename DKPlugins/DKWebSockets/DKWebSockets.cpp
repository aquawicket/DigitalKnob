//https://github.com/uNetworking/uWebSockets/blob/master/tests/main.cpp

#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

//SERVER
DKString DKWebSockets::serverAddress;
int DKWebSockets::serverPort = NULL;
uWS::WebSocket<uWS::SERVER>* DKWebSockets::serverWebSocket = NULL;
uWS::Hub DKWebSockets::serverHub;
char* DKWebSockets::serverMessage = NULL;
size_t DKWebSockets::serverLength = NULL;
uWS::OpCode DKWebSockets::serverOpCode;

//CLIENT
DKString DKWebSockets::clientAddress;
int DKWebSockets::clientPort = NULL;
uWS::WebSocket<uWS::CLIENT>* DKWebSockets::clientWebSocket = NULL;
uWS::Hub DKWebSockets::clientHub;
char* DKWebSockets::clientMessage = NULL;
size_t DKWebSockets::clientLength = NULL;
uWS::OpCode DKWebSockets::clientOpCode;

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
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseClient()
{
	//TODO
	return false;
}

////////////////////////////////
bool DKWebSockets::CloseServer()
{
	DKLog("DKWebSockets::CreateServer()\n", DKDEBUG);
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	serverPort = NULL;
	serverWebSocket = NULL;
	serverMessage = NULL;
	serverLength = NULL;
	DKLog("DKWebSockets::CreateServer(): Server closed\n", DKINFO);
	return true;
}

////////////////////////////////////////////////////////
bool DKWebSockets::CreateClient(const DKString& address)
{
	//TODO
	return false;
}

/////////////////////////////////////////////////////////////////////////
bool DKWebSockets::CreateServer(const DKString& address, const int& port)
{
	serverAddress = address;
	serverPort = port;
	DKLog("DKWebSockets::CreateServer("+address+","+toString(port)+")\n", DKINFO);

	serverHub.onError([](void *user){
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

	serverHub.onConnection([](uWS::WebSocket<uWS::SERVER> *ws, uWS::HttpRequest req){
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

	serverHub.onDisconnection([](uWS::WebSocket<uWS::SERVER> *ws, int code, char *message, size_t length) {
		DKLog("Client got disconnected with data:ws->getUserData(), code:"+toString(code)+", message:<"+DKString(message, length)+">\n", DKINFO);
	});

	serverHub.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode){
		MessageFromClient(ws, message, length, opCode);
	});

	DKLog("DKWebSockets::CreateServer(): Server started...\n", DKINFO);
	return true;
}

/////////////////////////
void DKWebSockets::Loop()
{
	if(!serverAddress.empty() && serverPort && serverHub.listen(serverAddress.c_str(), serverPort)){
		serverHub.poll();
	}
	if(serverAddress.empty() && serverPort && serverHub.listen(serverPort)){
		serverHub.poll();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKWebSockets::MessageFromClient(uWS::WebSocket<uWS::SERVER>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	DKLog("DKWebSockets::ProcessMessage("+DKString(message)+","+toString(length)+")\n", DKDEBUG);
	serverWebSocket = ws;
	serverMessage = message;
	serverLength = length;
	serverOpCode = opCode;
	//DKLog("DKWebSockets::ProcessMessage(): _message = "+DKString(_message)+"\n", DKINFO);
	//DKLog("DKWebSockets::ProcessMessage(): _length = "+toString(_length)+"\n", DKINFO);
	DKString message_  = DKString(serverMessage).substr(0, serverLength);
	//DKLog("DKWebSockets::ProcessMessage(): message_ = "+DKString(message_)+"\n", DKINFO);
	DKEvent::SendEvent("GLOBAL", "DKWebSockets_OnMessage", message_);
	return true;
}

///////////////////////////////////////////////////////////
bool DKWebSockets::MessageToClient(const DKString& message)
{
	DKLog("DKWebSockets::SendMessage("+message+")\n", DKINFO);//, DKDEBUG);

	DKString message_ = toString(serverMessage);
	message_ = message_.substr(serverLength, message_.length()); //strip the message
	//DKLog("DKWebSockets::SendMessage(): message_ = "+message_+"\n", DKINFO);
	message_ = message+message_;
	size_t length_ = message.length();
	uWS::OpCode opCode_ = serverOpCode;

	//DKLog("DKWebSockets::SendMessage(): message_ = "+DKString(message_)+"\n", DKINFO);
	//DKLog("DKWebSockets::SendMessage(): length_ = "+toString(length_)+"\n", DKINFO);
	serverWebSocket->send(message_.c_str(), length_, opCode_);
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKWebSockets::MessageFromServer(uWS::WebSocket<uWS::CLIENT>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	//TODO
	return false;
}

///////////////////////////////////////////////////////////
bool DKWebSockets::MessageToServer(const DKString& message)
{
	//TODO
	return false;
}