/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
//https://github.com/uNetworking/uWebSockets/blob/master/tests/main.cpp
#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"
#include "DKRml/DKRml.h"

//SERVER
DKString DKWebSockets::serverAddress;
int DKWebSockets::serverPort = NULL;
uWS::WebSocket<uWS::SERVER>* DKWebSockets::serverWebSocket = NULL;
uWS::Hub DKWebSockets::serverHub;

//CLIENT
DKString DKWebSockets::clientAddress;
uWS::WebSocket<uWS::CLIENT>* DKWebSockets::clientWebSocket = NULL;
uWS::Hub DKWebSockets::clientHub;


bool DKWebSockets::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKWebSocketsJS");
	DKClass::DKCreate("DKWebSocketsV8");
	DKApp::AppendLoopFunc(&DKWebSockets::Loop, this);
	return true;
}

bool DKWebSockets::End(){
	DKDEBUGFUNC();
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	return true;
}

bool DKWebSockets::CloseClient(){
	DKDEBUGFUNC();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	clientWebSocket = NULL;
	return DKINFO("Client closed \n");
}

bool DKWebSockets::CloseServer(){
	DKDEBUGFUNC();
	serverHub.getDefaultGroup<uWS::SERVER>().close();
	serverPort = NULL;
	serverWebSocket = NULL;
	return DKINFO("Server closed \n");
}

bool DKWebSockets::CreateClient(const DKString& address){
	DKDEBUGFUNC(address);
	clientAddress = address;

	clientHub.onConnection([](uWS::WebSocket<uWS::CLIENT> *ws, uWS::HttpRequest req){
		DKDEBUGFUNC(ws, req);
		clientWebSocket = ws;
	});

	clientHub.onDisconnection([](uWS::WebSocket<uWS::CLIENT> *ws, int code, char *message, size_t length) {
		DKDEBUGFUNC(ws, code, message, length);
		clientWebSocket = NULL;
	});

	clientHub.onError([](void *user){
		DKDEBUGFUNC(user);
		clientWebSocket = NULL;
		switch ((long) user){
		case 1:
			DKERROR("Client emitted error on invalid URI \n");
			break;
		case 2:
			DKERROR("Client emitted error on resolve failure \n");
			break;
		case 3:
			DKERROR("Client emitted error on connection timeout (non-SSL) \n");
			break;
		case 5:
			DKERROR("Client emitted error on connection timeout (SSL) \n");
			break;
		case 6:
			DKERROR("Client emitted error on HTTP response without upgrade (non-SSL) \n");
			break;
		case 7:
			DKERROR("Client emitted error on HTTP response without upgrade (SSL) \n");
			break;
		case 10:
			DKERROR("Client emitted error on poll error \n");
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
		DKDEBUGFUNC(ws, message, length, opCode);
		MessageFromServer(ws, message, length, opCode);
	});

	clientHub.poll();
	clientHub.connect(address, NULL);
	
	return DKINFO("DKWebSockets::CreateClient(): Client started... \n");
}

bool DKWebSockets::CreateServer(const DKString& address, const int& port){
	DKDEBUGFUNC(address, port);
	serverAddress = address;
	serverPort = port;

	serverHub.onError([](void *user){
		DKDEBUGFUNC(user);
		serverWebSocket = NULL;
		switch ((long) user){
		case 1:
			DKERROR("Client emitted error on invalid URI \n");
			break;
		case 2:
			DKERROR("Client emitted error on resolve failure \n");
			break;
		case 3:
			DKERROR("Client emitted error on connection timeout (non-SSL) \n");
			break;
		case 5:
			DKERROR("Client emitted error on connection timeout (SSL) \n");
			break;
		case 6:
			DKERROR("Client emitted error on HTTP response without upgrade (non-SSL) \n");
			break;
		case 7:
			DKERROR("Client emitted error on HTTP response without upgrade (SSL) \n");
			break;
		case 10:
			DKERROR("Client emitted error on poll error \n");
			break;
		case 11:
			static int protocolErrorCount = 0;
			protocolErrorCount++;
			DKERROR("Client emitted error on invalid protocol \n");
			if (protocolErrorCount > 1) {
				DKERROR("FAILURE: "+toString(protocolErrorCount)+" errors emitted for one connection! \n");
				exit(-1);
			}
			break;
		//default:
			//std::cout << "FAILURE: " << user << " should not emit error!" << std::endl;
			//exit(-1);
		}
	});

	serverHub.onConnection([](uWS::WebSocket<uWS::SERVER> *ws, uWS::HttpRequest req){
		DKDEBUGFUNC(ws, req);
		serverWebSocket = ws;
		switch ((long) ws->getUserData()) {
		case 8:
			DKINFO("Client established a remote connection over non-SSL \n");
			break;
		case 9:
			DKINFO("Client established a remote connection over SSL \n");
			break;
		default:
			DKINFO("FAILURE: ws->getUserData() should not connect! \n");
		}
	});

	serverHub.onDisconnection([](uWS::WebSocket<uWS::SERVER> *ws, int code, char *message, size_t length) {
		DKDEBUGFUNC(ws, code, message, length);
		serverWebSocket = NULL;
		DKINFO("Client got disconnected with data:ws->getUserData(), code:"+toString(code)+", message:<"+DKString(message, length)+"> \n");
	});

	serverHub.onMessage([](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode){
		DKDEBUGFUNC(ws, message, length, opCode);
		MessageFromClient(ws, message, length, opCode);
	});

	return DKINFO("DKWebSockets::CreateServer(): Server started... \n");
}

void DKWebSockets::Loop(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if(!serverAddress.empty() && serverPort && serverHub.listen(serverAddress.c_str(), serverPort))
		serverHub.poll();
	if(serverAddress.empty() && serverPort && serverHub.listen(serverPort))
		serverHub.poll();
	if(!clientAddress.empty())
		clientHub.poll();
}

bool DKWebSockets::MessageFromClient(uWS::WebSocket<uWS::SERVER>* ws, char *message, size_t length, uWS::OpCode opCode){
	DKDEBUGFUNC(ws, message, length, opCode);
	DKString message_  = DKString(message).substr(0, length);
	DKINFO("DKWebSockets::MessageFromClient(): "+message_+"\n");
	DKEvents::SendEvent("window", "DKWebSockets_OnMessageFromClient", message_);
	return true;
}

bool DKWebSockets::MessageFromServer(uWS::WebSocket<uWS::CLIENT>* ws, char *message, size_t length, uWS::OpCode opCode){
	DKDEBUGFUNC(ws, message, length, opCode);
	DKString message_  = DKString(message).substr(0, length);
	DKINFO("DKWebSockets::MessageFromServer(): " + message_ + "\n");
	DKEvents::SendEvent("window", "DKWebSockets_OnMessageFromServer", message_);
	return true;
}

bool DKWebSockets::MessageToClient(const DKString& message){
	DKDEBUGFUNC(message);
	std::vector<std::string> messages = {message};
	std::vector<int> excludes;
	if(!serverWebSocket)
		return DKERROR("serverWebSocket is invalid! \n");
	uWS::WebSocket<uWS::SERVER>::PreparedMessage *prepared = serverWebSocket->prepareMessageBatch(messages, excludes, uWS::OpCode::TEXT, false, nullptr);
	serverWebSocket->sendPrepared(prepared, nullptr);
	serverWebSocket->finalizeMessage(prepared);
	return true;
}

bool DKWebSockets::MessageToServer(const DKString& message){
	DKDEBUGFUNC(message);
	std::vector<std::string> messages = {message};
	std::vector<int> excludes;
	if(!clientWebSocket)
		return DKERROR("clientWebSocket is invalid! \n");
	uWS::WebSocket<uWS::CLIENT>::PreparedMessage *prepared = clientWebSocket->prepareMessageBatch(messages, excludes, uWS::OpCode::TEXT, false, nullptr);
	clientWebSocket->sendPrepared(prepared, nullptr);
	clientWebSocket->finalizeMessage(prepared);
	return true;
}
