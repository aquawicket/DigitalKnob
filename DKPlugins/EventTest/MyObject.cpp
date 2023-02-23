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
#include "EventTest/MyObject.h"


bool MyObject::Init(){
	DKDEBUGFUNC();
	DKINFO(toString(data, ",") + "\n");
	DKDuktape::AttachFunction("CPP_MyObject_value", MyObject::value);
	DKDuktape::AttachFunction("CPP_MyObject_test", MyObject::test);
	return true;
}

bool MyObject::End(){
	DKDEBUGFUNC();
	return true;
}

bool MyObject::instance_value(){
	DKINFO("MyObject::instance_value("+data[0] + ")\n");
	return true;
}

bool MyObject::instance_test() {
	DKINFO("MyObject::instance_test("+data[1] + ")\n");
	return true;
}

int MyObject::value(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKINFO("MyObject::value(): address = " + address + "\n");
	MyObject* object = (MyObject*)DKDuktape::addressToDKObject(address);
	object->instance_value();
	return true;
}

int MyObject::test(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKINFO("MyObject::value(): test = " + address + "\n");
	MyObject* object = (MyObject*)DKDuktape::addressToDKObject(address);
	object->instance_test();
	return true;
}
