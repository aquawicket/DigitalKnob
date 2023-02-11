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
#include "DKUWebSocketsClient/DKUWebSocketsClient.h"
#include "DKRml/DKRml.h"


bool DKUWebSocketsClient::Init(){
	DKDEBUGFUNC();
	DKINFO(toString(data, ",") + "\n");
	DKApp::AppendLoopFunc(&DKUWebSocketsClient::Loop, this);
	return true;
}

bool DKUWebSocketsClient::End(){
	DKDEBUGFUNC();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	return true;
}

bool DKUWebSocketsClient::CloseClient(){
	DKDEBUGFUNC();
	clientHub.getDefaultGroup<uWS::CLIENT>().close();
	clientWebSocket = NULL;
	return DKINFO("Client closed \n");
}

bool DKUWebSocketsClient::CreateClient(const DKString& address){
	DKDEBUGFUNC(address);
	clientAddress = address;

	clientHub.onConnection([this](uWS::WebSocket<uWS::CLIENT> *ws, uWS::HttpRequest req){
		DKDEBUGFUNC(ws, req);
		//DKINFO("clientHub.onConnection() \n");
		clientWebSocket = ws;
		DKRml::Get()->SendEvent(data[1], "open", "");
	});

	clientHub.onDisconnection([this](uWS::WebSocket<uWS::CLIENT> *ws, int code, char *message, size_t length) {
		DKDEBUGFUNC(ws, code, message, length);
		//DKINFO("clientHub.onDisconnection() \n");
		clientWebSocket = NULL;
		DKRml::Get()->SendEvent(data[1], "close", "");
	});

	clientHub.onError([this](void *user){
		DKDEBUGFUNC(user);
		//DKINFO("clientHub.onError() \n");
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
		DKRml::Get()->SendEvent(data[1], "error", "");
	});

	clientHub.onMessage([this](uWS::WebSocket<uWS::CLIENT> *ws, char *message, size_t length, uWS::OpCode opCode){
		DKDEBUGFUNC(ws, message, length, opCode);
		//DKINFO("clientHub.onMessage() \n");
		MessageFromServer(ws, message, length, opCode);
	});

	clientHub.poll();
	clientHub.connect(address, NULL);
	
	DKRml::Get()->SendEvent(data[1], "init", "");
	return DKINFO("DKUWebSocketsClient::CreateClient(): Client started... \n");
}

void DKUWebSocketsClient::Loop(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if(!clientAddress.empty())
		clientHub.poll();
}

bool DKUWebSocketsClient::MessageFromServer(uWS::WebSocket<uWS::CLIENT>* ws, char *message, size_t length, uWS::OpCode opCode){
	DKDEBUGFUNC(ws, message, length, opCode);
	DKString message_  = DKString(message).substr(0, length);
	DKINFO("DKUWebSocketsClient::MessageFromServer(): " + message_ + "\n");
	DKRml::Get()->SendEvent(data[1], "message", message_);
	return true;
}

bool DKUWebSocketsClient::MessageToServer(const DKString& message){
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
