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
uWS::WebSocket<uWS::CLIENT>* DKWebSockets::clientWebSocket = NULL;
uWS::Hub DKWebSockets::clientHub;


/////////////////////////
bool DKWebSockets::Init()
{
	DKDebug();
	DKClass::DKCreate("DKWebSocketsJS");
	DKClass::DKCreate("DKWebSocketsV8");
	DKApp::AppendLoopFunc(&DKWebSockets::Loop, this);
	return true;
}

////////////////////////
bool DKWebSockets::End()
{
	DKDebug();
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseClient()
{
	DKDebug();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	clientWebSocket = NULL;
	DKLog("DKWebSockets::CloseClient(): Client closed\n");
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseServer()
{
	DKDebug();
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	serverPort = NULL;
	serverWebSocket = NULL;
	DKLog("DKWebSockets::CloseServer(): Server closed\n");
	return true;
}

////////////////////////////////////////////////////////
bool DKWebSockets::CreateClient(const DKString& address)
{
	DKDebug(address);
	clientAddress = address;
	clientHub.onError([](void *user){
		DKLog("DKWebSockets::CreateClient(): clientHub.onError: "+toString((long)user)+"\n", DKERROR);
		clientWebSocket = NULL;
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

	clientHub.onConnection([](uWS::WebSocket<uWS::CLIENT> *ws, uWS::HttpRequest req){
		DKLog("DKWebSockets::CreateClient(): clientHub.onConnection\n");
		clientWebSocket = ws;
	});

	clientHub.onDisconnection([](uWS::WebSocket<uWS::CLIENT> *ws, int code, char *message, size_t length) {
		DKLog("DKWebSockets::CreateClient(): clientHub.onDisconnection\n");
		clientWebSocket = NULL;
	});

	clientHub.onMessage([](uWS::WebSocket<uWS::CLIENT> *ws, char *message, size_t length, uWS::OpCode opCode){
		DKLog("DKWebSockets::CreateClient(): clientHub.onMessage\n");
		MessageFromServer(ws, message, length, opCode);
	});

	clientHub.poll();
	clientHub.connect(address, NULL);
	
	DKLog("DKWebSockets::CreateClient(): Client started...\n");
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKWebSockets::CreateServer(const DKString& address, const int& port)
{
	DKDebug(address, port);
	serverHub.onError([](void *user){
		DKLog("DKWebSockets::CreateServer(): serverHub.onError\n", DKERROR);
		serverWebSocket = NULL;
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
		DKLog("DKWebSockets::CreateServer(): serverHub.onConnection\n");
		serverWebSocket = ws;
		switch ((long) ws->getUserData()) {
		case 8:
			DKLog("Client established a remote connection over non-SSL");
			break;
		case 9:
			DKLog("Client established a remote connection over SSL");
			break;
		default:
			DKLog("FAILURE: ws->getUserData() should not connect!");
		}
	});

	serverHub.onDisconnection([](uWS::WebSocket<uWS::SERVER> *ws, int code, char *message, size_t length) {
		serverWebSocket = NULL;
		DKLog("Client got disconnected with data:ws->getUserData(), code:"+toString(code)+", message:<"+DKString(message, length)+">\n");
	});

	serverHub.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode){
		DKLog("DKWebSockets::CreateServer(): serverHub.serverHub.onMessage\n");
		MessageFromClient(ws, message, length, opCode);
	});

	DKLog("DKWebSockets::CreateServer(): Server started...\n");
	return true;
}

/////////////////////////
void DKWebSockets::Loop()
{
	//DKDebug();
	if(!serverAddress.empty() && serverPort && serverHub.listen(serverAddress.c_str(), serverPort)){
		serverHub.poll();
	}
	if(serverAddress.empty() && serverPort && serverHub.listen(serverPort)){
		serverHub.poll();
	}
	if(!clientAddress.empty()){
		clientHub.poll();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKWebSockets::MessageFromClient(uWS::WebSocket<uWS::SERVER>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	DKDebug(ws, message, length, opCode);
	DKString message_  = DKString(message).substr(0, length);
	DKEvent::SendEvent("GLOBAL", "DKWebSockets_OnMessageFromClient", message_);
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKWebSockets::MessageFromServer(uWS::WebSocket<uWS::CLIENT>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	DKDebug(ws, message, length, opCode);
	DKString message_  = DKString(message).substr(0, length);
	DKEvent::SendEvent("GLOBAL", "DKWebSockets_OnMessageFromServer", message_);
	return true;
}

///////////////////////////////////////////////////////////
bool DKWebSockets::MessageToClient(const DKString& message)
{
	DKDebug(message);
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
	DKDebug(message);
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