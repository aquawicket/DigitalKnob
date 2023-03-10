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
#include "EventTest/CPPObject.h"


bool CPPObject::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_CPPObject_value", CPPObject::value);
	DKDuktape::AttachFunction("CPP_CPPObject_test", CPPObject::test);
	return true;
}

bool CPPObject::End(){
	DKDEBUGFUNC();
	return true;
}

bool CPPObject::instance_value(){
	DKINFO("CPPObject::instance_value("+data[0] + ")\n");
	return true;
}

bool CPPObject::instance_test() {
	DKINFO("CPPObject::instance_test("+data[1] + ")\n");
	instance_sendevent();
	return true;
}

bool CPPObject::instance_sendevent() {
	DKINFO("CPPObject::instance_sendevent()\n");
	DKString type = "myCPPEvent";
	DKDuktape::doEvent(type, "", this);
	return true;
}

int CPPObject::value(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKINFO("CPPObject::value(): address = " + address + "\n");
	CPPObject* object = (CPPObject*)DKDuktape::addressToPointer(address);
	object->instance_value();
	return true;
}

int CPPObject::test(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKINFO("CPPObject::value(): test = " + address + "\n");
	CPPObject* object = (CPPObject*)DKDuktape::addressToPointer(address);
	object->instance_test();
	return true;
}
