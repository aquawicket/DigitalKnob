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

/// WEBSOCKETS CLIENT TEST ///
var client = new WebSocket("ws://192.168.1.47:80");

//client.onclose = function onclose(event){
client.addEventListener("close", function onclose(event){
	console.log("client.onclose("+event+")");
	console.log("event.value = "+event.value);
})

//client.onerror = function onerror(event){
client.addEventListener("error", function onerror(event){
	console.log("client.onerror("+event+")");
	console.log("event.value = "+event.value);
})

//client.onmessage = function onmessage(event){
client.addEventListener("message", function onmessage(event){
	console.log("client.onmessage("+event+")");
	console.log("event.value = "+event.value);
})

//client.onopen = function onopen(event){
client.addEventListener("open", function onopen(event){
	console.log("client.onopen("+event+")");
	console.log("event.value = "+event.value);
	client.send("test message");
})
