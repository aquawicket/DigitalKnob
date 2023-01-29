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

#pragma once
#ifndef DKWebSockets_H
#define DKWebSockets_H

WARNING_DISABLE
#include "src/uWS.h"
WARNING_ENABLE

#include "DK/DK.h"


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

	//CLIENT
	static DKString clientAddress;
	static uWS::Hub clientHub;
	static uWS::WebSocket<uWS::CLIENT>* clientWebSocket;
};
REGISTER_OBJECT(DKWebSockets, true);


#endif //DKWebSockets_H
