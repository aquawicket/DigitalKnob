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

DKPlugin("DKFile/DKFile.js")
DKPlugin("DKDebug/DKDebug.js") //add dkpush, etc.

/*
/// WEB TEST ///
const url = "DKWebTest/index.html"
location.href = url
DKPlugin("DK/DKPhp.js")
DKPlugin("DKFile/DKFile.js")
*/

/// WEBSOCKETS TEST ///
var server = 0
if(server){
	/// WEBSOCKETS SERVER TEST ///
	var server = new WebSocketServer("ws://192.168.1.47:80");
	console.log("server = "+server)
	server.onclose = function(event){
		console.log("server.onclose("+event+")");
	}
	server.onmessage = function(event){
		console.log("server.onmessage("+event+")");
	}
	server.onopen = function(event){
		console.log("server.onopen("+event+")");
	}
	
	server.start("192.168.1.47", "80");
}
else{
	/// WEBSOCKETS CLIENT TEST ///
	var client = new WebSocket("ws://192.168.1.47:80");
	client.onopen = function(event){
		console.log("client.onopen("+event+")");
	}
	client.onmessage = function(event){
		console.log("client.onmessage("+event+")");
	}
	client.onclose = function(event){
		console.log("client.onclose("+event+")");
	}
	client.onerror = function(event){
		console.log("client.onerror("+event+")");
	}
	
	client.send("test message");
}
