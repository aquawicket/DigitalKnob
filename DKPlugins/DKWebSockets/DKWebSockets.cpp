//https://github.com/uNetworking/uWebSockets/blob/master/tests/main.cpp

#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

//SERVER
DKString DKWebSockets::serverAddress;
int DKWebSockets::serverPort = NULL;
uWS::WebSocket<uWS::SERVER>* DKWebSockets::serverWebSocket = NULL;
uWS::Hub DKWebSockets::serverHub;

//CLIENT
DKString DKWebSockets::clientAddress;
int DKWebSockets::clientPort = NULL;
uWS::WebSocket<uWS::CLIENT>* DKWebSockets::clientWebSocket = NULL;
uWS::Hub DKWebSockets::clientHub;


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
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseClient()
{
	DKLog("DKWebSockets::CloseClient()\n", DKDEBUG);
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	clientPort = NULL;
	clientWebSocket = NULL;
	DKLog("DKWebSockets::CloseClient(): Client closed\n", DKINFO);
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseServer()
{
	DKLog("DKWebSockets::CloseServer()\n", DKDEBUG);
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	serverPort = NULL;
	serverWebSocket = NULL;
	DKLog("DKWebSockets::CloseServer(): Server closed\n", DKINFO);
	return true;
}

////////////////////////////////////////////////////////
bool DKWebSockets::CreateClient(const DKString& address)
{
	clientAddress = address;
	clientPort = 80;
	DKLog("DKWebSockets::CreateClient("+address+")\n", DKINFO);

	clientHub.onError([](void *user){
		DKLog("DKWebSockets::CreateClient(): clientHub.onError\n", DKINFO);
	});

	clientHub.onConnection([](uWS::WebSocket<uWS::CLIENT> *ws, uWS::HttpRequest req){
		clientWebSocket = ws;
		switch ((long) ws->getUserData()) {
		case 8:
			DKLog("Client established a remote connection over non-SSL\n", DKINFO);
			break;
		case 9:
			DKLog("Client established a remote connection over SSL\n", DKINFO);
			break;
		default:
			DKLog("FAILURE: ws->getUserData() should not connect!\n", DKINFO);
		}
	});

	clientHub.onMessage([](uWS::WebSocket<uWS::CLIENT> *ws, char *message, size_t length, uWS::OpCode opCode){
		MessageFromServer(ws, message, length, opCode);
	});

	clientHub.connect(address, nullptr);
	DKLog("DKWebSockets::CreateClient(): Client started...\n", DKINFO);
	return true;
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
		serverWebSocket = ws;
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
	DKLog("DKWebSockets::MessageFromClient("+DKString(message)+","+toString(length)+")\n", DKDEBUG);
	//DKLog("DKWebSockets::MessageFromClient(): _message = "+DKString(_message)+"\n", DKINFO);
	//DKLog("DKWebSockets::MessageFromClient(): _length = "+toString(_length)+"\n", DKINFO);
	DKString message_  = DKString(message).substr(0, length);
	//DKLog("DKWebSockets::MessageFromClient(): message_ = "+DKString(message_)+"\n", DKINFO);
	DKEvent::SendEvent("GLOBAL", "DKWebSockets_OnMessageFromClient", message_);
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKWebSockets::MessageFromServer(uWS::WebSocket<uWS::CLIENT>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	DKLog("DKWebSockets::MessageFromServer("+DKString(message)+","+toString(length)+")\n", DKDEBUG);
	//DKLog("DKWebSockets::MessageFromServer(): _message = "+DKString(_message)+"\n", DKINFO);
	//DKLog("DKWebSockets::MessageFromServer(): _length = "+toString(_length)+"\n", DKINFO);
	DKString message_  = DKString(message).substr(0, length);
	//DKLog("DKWebSockets::MessageFromServer(): message_ = "+DKString(message_)+"\n", DKINFO);
	DKEvent::SendEvent("GLOBAL", "DKWebSockets_OnMessageFromServer", message_);
	return true;
}

///////////////////////////////////////////////////////////
bool DKWebSockets::MessageToClient(const DKString& message)
{
	DKLog("DKWebSockets::MessageToClient("+message+")\n", DKINFO);//, DKDEBUG);

	std::vector<std::string> messages = {message};
	std::vector<int> excludes;
	if(!serverWebSocket){
		DKLog("DKWebSockets::MessageToServer("+message+"): serverWebSocket is invalid\n", DKERROR);
		return false;
	}
	uWS::WebSocket<uWS::SERVER>::PreparedMessage *prepared = serverWebSocket->prepareMessageBatch(messages, excludes, uWS::OpCode::TEXT, false, nullptr);
	serverWebSocket->sendPrepared(prepared, nullptr);
	serverWebSocket->finalizeMessage(prepared);
	return true;
}

///////////////////////////////////////////////////////////
bool DKWebSockets::MessageToServer(const DKString& message)
{
	DKLog("DKWebSockets::MessageToServer("+message+")\n", DKINFO);//, DKDEBUG);

	std::vector<std::string> messages = {message};
	std::vector<int> excludes;
	if(!clientWebSocket){
		DKLog("DKWebSockets::MessageToServer("+message+"): clientWebSocket is invalid\n", DKERROR);
		return false;
	}
	uWS::WebSocket<uWS::CLIENT>::PreparedMessage *prepared = clientWebSocket->prepareMessageBatch(messages, excludes, uWS::OpCode::TEXT, false, nullptr);
	clientWebSocket->sendPrepared(prepared, nullptr);
	clientWebSocket->finalizeMessage(prepared);
	return true;
}