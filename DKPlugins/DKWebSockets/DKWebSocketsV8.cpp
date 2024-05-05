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
#ifdef HAVE_DKCef
#include "DK/DKApp.h"
#include "DKWebSockets/DKWebSockets.h"
#include "DKWebSockets/DKWebSocketsV8.h"


bool DKWebSocketsV8::Init(){
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKWebSockets_CloseClient", DKWebSocketsV8::CloseClient);
	DKV8::AttachFunction("DKWebSockets_CloseServer", DKWebSocketsV8::CloseServer);
	DKV8::AttachFunction("DKWebSockets_CreateClient", DKWebSocketsV8::CreateClient);
	DKV8::AttachFunction("DKWebSockets_CreateServer", DKWebSocketsV8::CreateServer);
	DKV8::AttachFunction("DKWebSockets_MessageToClient", DKWebSocketsV8::MessageToClient);
	DKV8::AttachFunction("DKWebSockets_MessageToServer", DKWebSocketsV8::MessageToServer);
	return true;
}

bool DKWebSocketsV8::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKWebSocketsV8::CloseClient(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKWebSockets::CloseClient())
		return DKERROR("DKWebSockets::CloseClient() failed! \n");
	return true;
}

bool DKWebSocketsV8::CloseServer(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKWebSockets::CloseServer())
		return DKERROR("DKWebSockets::CloseServer() failed! \n");
	return true;
}

bool DKWebSocketsV8::CreateClient(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString address = args->GetString(0);
	if(!DKWebSockets::CreateClient(address))
		return DKERROR("DKWebSockets::CreateClient() failed! \n");
	return true;
}

bool DKWebSocketsV8::CreateServer(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString address = args->GetString(0);
	int port = args->GetInt(1);
	if(!DKWebSockets::CreateServer(address, port))
		return DKERROR("DKWebSockets::CreateServer() failed! \n");
	return true;
}

bool DKWebSocketsV8::MessageToClient(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString text = args->GetString(0);
	if(!DKWebSockets::MessageToClient(text))
		return DKERROR("DKWebSockets::MessageToClient() failed! \n");
	return true;
}

bool DKWebSocketsV8::MessageToServer(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString text = args->GetString(0);
	if(!DKWebSockets::MessageToServer(text))
		return DKERROR("DKWebSockets::MessageToServer() failed! \n");
	return true;
}


#endif //HAVE_DKCef
