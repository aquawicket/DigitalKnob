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
	DKDEBUGFUNC();
	DKClass::DKCreate("DKWebSocketsJS");
	DKClass::DKCreate("DKWebSocketsV8");
	DKApp::AppendLoopFunc(&DKWebSockets::Loop, this);
	return true;
}

////////////////////////
bool DKWebSockets::End()
{
	DKDEBUGFUNC();
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseClient()
{
	DKDEBUGFUNC();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	clientWebSocket = NULL;
	DKINFO("DKWebSockets::CloseClient(): Client closed\n");
	return true;
}

////////////////////////////////
bool DKWebSockets::CloseServer()
{
	DKDEBUGFUNC();
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	serverPort = NULL;
	serverWebSocket = NULL;
	DKINFO("DKWebSockets::CloseServer(): Server closed\n");
	return true;
}

////////////////////////////////////////////////////////
bool DKWebSockets::CreateClient(const DKString& address)
{
	DKDEBUGFUNC(address);
	clientAddress = address;

	clientHub.onConnection([](uWS::WebSocket<uWS::CLIENT> *ws, uWS::HttpRequest req){
		DKINFO("DKWebSockets::CreateClient(): clientHub.onConnection\n");
		clientWebSocket = ws;
	});

	clientHub.onDisconnection([](uWS::WebSocket<uWS::CLIENT> *ws, int code, char *message, size_t length) {
		DKINFO("DKWebSockets::CreateClient(): clientHub.onDisconnection\n");
		clientWebSocket = NULL;
	});

	clientHub.onError([](void *user){
		DKERROR("DKWebSockets::CreateClient(): clientHub.onError: "+toString((long)user)+"\n");
		clientWebSocket = NULL;
		switch ((long) user){
		case 1:
			DKERROR("Client emitted error on invalid URI\n");
			break;
		case 2:
			DKERROR("Client emitted error on resolve failure\n");
			break;
		case 3:
			DKERROR("Client emitted error on connection timeout (non-SSL)\n");
			break;
		case 5:
			DKERROR("Client emitted error on connection timeout (SSL)\n");
			break;
		case 6:
			DKERROR("Client emitted error on HTTP response without upgrade (non-SSL)\n");
			break;
		case 7:
			DKERROR("Client emitted error on HTTP response without upgrade (SSL)\n");
			break;
		case 10:
			DKERROR("Client emitted error on poll error\n");
			break;
		case 11:
			static int protocolErrorCount = 0;
			protocolErrorCount++;
			DKERROR("Client emitted error on invalid protocol\n");
			if (protocolErrorCount > 1) {
				DKERROR("FAILURE: "+toString(protocolErrorCount)+" errors emitted for one connection!\n");
				exit(-1);
			}
			break;
			//default:
			//std::cout << "FAILURE: " << user << " should not emit error!" << std::endl;
			//exit(-1);
		}
	});

	clientHub.onMessage([](uWS::WebSocket<uWS::CLIENT> *ws, char *message, size_t length, uWS::OpCode opCode){
		DKINFO("DKWebSockets::CreateClient(): clientHub.onMessage\n");
		MessageFromServer(ws, message, length, opCode);
	});

	clientHub.poll();
	clientHub.connect(address, NULL);
	
	DKINFO("DKWebSockets::CreateClient(): Client started...\n");
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKWebSockets::CreateServer(const DKString& address, const int& port)
{
	DKDEBUGFUNC(address, port);
	serverAddress = address;
	serverPort = port;

	serverHub.onError([](void *user){
		DKERROR("DKWebSockets::CreateServer(): serverHub.onError\n");
		serverWebSocket = NULL;
		switch ((long) user){
		case 1:
			DKERROR("Client emitted error on invalid URI\n");
			break;
		case 2:
			DKERROR("Client emitted error on resolve failure\n");
			break;
		case 3:
			DKERROR("Client emitted error on connection timeout (non-SSL)\n");
			break;
		case 5:
			DKERROR("Client emitted error on connection timeout (SSL)\n");
			break;
		case 6:
			DKERROR("Client emitted error on HTTP response without upgrade (non-SSL)\n");
			break;
		case 7:
			DKERROR("Client emitted error on HTTP response without upgrade (SSL)\n");
			break;
		case 10:
			DKERROR("Client emitted error on poll error\n");
			break;
		case 11:
			static int protocolErrorCount = 0;
			protocolErrorCount++;
			DKERROR("Client emitted error on invalid protocol\n");
			if (protocolErrorCount > 1) {
				DKERROR("FAILURE: "+toString(protocolErrorCount)+" errors emitted for one connection!\n");
				exit(-1);
			}
			break;
		//default:
			//std::cout << "FAILURE: " << user << " should not emit error!" << std::endl;
			//exit(-1);
		}
	});

	serverHub.onConnection([](uWS::WebSocket<uWS::SERVER> *ws, uWS::HttpRequest req){
		DKINFO("DKWebSockets::CreateServer(): serverHub.onConnection\n");
		serverWebSocket = ws;
		switch ((long) ws->getUserData()) {
		case 8:
			DKINFO("Client established a remote connection over non-SSL");
			break;
		case 9:
			DKINFO("Client established a remote connection over SSL");
			break;
		default:
			DKINFO("FAILURE: ws->getUserData() should not connect!");
		}
	});

	serverHub.onDisconnection([](uWS::WebSocket<uWS::SERVER> *ws, int code, char *message, size_t length) {
		serverWebSocket = NULL;
		DKINFO("Client got disconnected with data:ws->getUserData(), code:"+toString(code)+", message:<"+DKString(message, length)+">\n");
	});

	serverHub.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode){
		DKINFO("DKWebSockets::CreateServer(): serverHub.serverHub.onMessage\n");
		MessageFromClient(ws, message, length, opCode);
	});

	DKINFO("DKWebSockets::CreateServer(): Server started...\n");
	return true;
}

/////////////////////////
void DKWebSockets::Loop()
{
	//DKDEBUGFUNC();
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
	DKDEBUGFUNC(ws, message, length, opCode);
	DKString message_  = DKString(message).substr(0, length);
	DKEvents::SendEvent("window", "DKWebSockets_OnMessageFromClient", message_);
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKWebSockets::MessageFromServer(uWS::WebSocket<uWS::CLIENT>* ws, char *message, size_t length, uWS::OpCode opCode)
{
	DKDEBUGFUNC(ws, message, length, opCode);
	DKString message_  = DKString(message).substr(0, length);
	DKEvents::SendEvent("window", "DKWebSockets_OnMessageFromServer", message_);
	return true;
}

///////////////////////////////////////////////////////////
bool DKWebSockets::MessageToClient(const DKString& message)
{
	DKDEBUGFUNC(message);
	std::vector<std::string> messages = {message};
	std::vector<int> excludes;
	if(!serverWebSocket){
		DKERROR("DKWebSockets::MessageToServer("+message+"): serverWebSocket is invalid\n");
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
	DKDEBUGFUNC(message);
	std::vector<std::string> messages = {message};
	std::vector<int> excludes;
	if(!clientWebSocket){
		DKERROR("DKWebSockets::MessageToServer("+message+"): clientWebSocket is invalid\n");
		return false;
	}
	uWS::WebSocket<uWS::CLIENT>::PreparedMessage *prepared = clientWebSocket->prepareMessageBatch(messages, excludes, uWS::OpCode::TEXT, false, nullptr);
	clientWebSocket->sendPrepared(prepared, nullptr);
	clientWebSocket->finalizeMessage(prepared);
	return true;
}