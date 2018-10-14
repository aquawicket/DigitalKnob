#pragma once
#ifndef DKWebSockets_H
#define DKWebSockets_H

#include "src/uWS.h"
#include "DK/DK.h"

///////////////////////////////////////////////////
class DKWebSockets : public DKObjectT<DKWebSockets>
{
public:
	bool Init();
	bool End();
	void Loop();

	static bool CloseClient();
	static bool CloseServer();
	static bool CreateClient(const DKString& address);
	static bool CreateServer(const DKString& address, const int& port);
	static bool MessageFromClient(uWS::WebSocket<uWS::SERVER>* ws, char *message, size_t length, uWS::OpCode opCode);
	static bool MessageFromServer(uWS::WebSocket<uWS::CLIENT>* ws, char *message, size_t length, uWS::OpCode opCode);
	static bool MessageToClient(const DKString& message);
	static bool MessageToServer(const DKString& message);

	//SERVER
	static DKString serverAddress;
	static int serverPort;
	static uWS::Hub serverHub;
	static uWS::WebSocket<uWS::SERVER>* serverWebSocket;
	static char* serverMessage;
	static size_t serverLength;
	static uWS::OpCode serverOpCode;

	//CLIENT
	static DKString clientAddress;
	static int clientPort;
	static uWS::Hub clientHub;
	static uWS::WebSocket<uWS::CLIENT>* clientWebSocket;
	static char* clientMessage;
	static size_t clientLength;
	static uWS::OpCode clientOpCode;
};


REGISTER_OBJECT(DKWebSockets, true);

#endif //DKWebSockets_H