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
#ifndef DKUWebSocketsServer_H
#define DKUWebSocketsServer_H

#include "DK/DK.h"

#if HAVE_DKDuktape
	#include "DKDuktape/DKDuktape.h"
#endif

WARNING_DISABLE
	//DISABLE_WARNING(4251)
	#include "src/uWS.h"
WARNING_ENABLE


class DKUWebSocketsServer : public DKObjectT<DKUWebSocketsServer>
{
public:
	bool Init();
	bool End();
	void Loop();

	bool CloseServer();
	bool CreateServer(const DKString& url, const int& port);
	bool MessageFromClient(uWS::WebSocket<uWS::SERVER>* ws, char *message, size_t length, uWS::OpCode opCode);
	bool MessageToClient(const DKString& message);

	DKString serverAddress;
	int serverPort;
	uWS::Hub serverHub;
	uWS::WebSocket<uWS::SERVER>* serverWebSocket;

#if HAVE_DKDuktape
	////////////////// DUKTAPE //////////////////
	//// Instance properties ////
	static int isConnected(duk_context* ctx);

	//// Instance methods ////
	static int disconnect(duk_context* ctx);
	static int send(duk_context* ctx);
	static int start(duk_context* ctx);
#endif
};
REGISTER_OBJECT(DKUWebSocketsServer, true);


#endif //DKUWebSocketsServer_H