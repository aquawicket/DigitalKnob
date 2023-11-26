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
#ifndef DKEvents_H
#define DKEvents_H

#include "DK/DKObject.h"

class DKObject;
class DKEvents{
public:
	static bool AddEvent(const DKString& id, const DKString& type, std::function<bool(DKEvents*)> func, DKObject* object);
	static bool AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, std::function<bool(DKEvents*)> func, DKObject* object);
	static bool RemoveEvent(const DKString& id, const DKString& type, const DKString& jsreturn);
	static bool RemoveEvents(const DKString& id, const DKString& type);
	static bool RemoveEvents(const DKString& variable); //variable can be id or jsreturn
	static bool RemoveEvents(DKObject* obj);
	static bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	static bool RenameEventId(const DKString& oldID, const DKString& newID);
	DKString GetId();
	DKString GetType();
	DKString GetJSReturn();
	DKString GetValue();
	DKString GetValue(int n);
	int GetKeyNum();
	static std::vector<DKEvents*> events;

private:
	DKEvents(){};
	DKString id;
	DKString type;
	DKString jsreturn;
	DKObject* object;

public:
	DKStringArray data;
	void* data2;
	std::function<bool(DKEvents*)> event_func;

	template<class T> 
	static bool AddEvent(const DKString& id, const DKString& type, bool (T::*func) (DKEvents*), T* _this){
		DKDEBUGFUNC(id, type, func, _this);
		return DKEvents::AddEvent(id, type, std::bind(func, _this, std::placeholders::_1), _this);
	};

	template<class T>
	static bool AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, bool (T::*func) (DKEvents*), T* _this){
		DKDEBUGFUNC(id, type, jsreturn, func, _this);
		return DKEvents::AddEvent(id, type, jsreturn, std::bind(func, _this, std::placeholders::_1), _this);
	};

	template<class T>
	static void AddRegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(func, _this);
		reg_funcs.push_back(std::bind(func, _this, std::placeholders::_1, std::placeholders::_2));
	}

	template<class T>
	static void RemoveRegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(func, _this);
		for(unsigned int i=0; i<reg_funcs.size(); ++i){
			//if (reg_funcs[i] == std::bind(func, _this, std::placeholders::_1, std::placeholders::_2)){
			//	reg_funcs.erase(reg_funcs.begin() + i);
			//}
		}
	}
	
	template<class T>
	static void AddUnegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(func, _this);
		unreg_funcs.push_back(std::bind(func, _this, std::placeholders::_1, std::placeholders::_2));
	}

	template<class T>
	static void RemoveUnegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(func, _this);
		for(unsigned int i=0; i<unreg_funcs.size(); ++i){
			//if (unreg_funcs[i] == std::bind(func, _this, std::placeholders::_1, std::placeholders::_2)){
			//	unreg_funcs.erase(unreg_funcs.begin() + i);
			//}
		}
	}
	
	template<class T>
	static void AddSendEventFunc(bool (T::*func)(const DKString&, const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(func, _this);
		send_funcs.push_back(std::bind(func, _this, std::placeholders::_1, std::placeholders::_2, std::placeholders::_3));
	}

	template<class T>
	static void RemoveSendEventFunc(bool (T::*func)(const DKString&, const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(func, _this);
		for(unsigned int i=0; i<send_funcs.size(); ++i){
			//if (send_funcs[i] == std::bind(func, _this, std::placeholders::_1, std::placeholders::_2, std::placeholders::_3)){
			//	send_funcs.erase(send_funcs.begin() + i);
			//}
		}
	}

	static std::vector<std::function<bool(const DKString&, const DKString&)> > reg_funcs;
	static std::vector<std::function<bool(const DKString&, const DKString&)> > unreg_funcs;
	static std::vector<std::function<bool(const DKString&, const DKString&, const DKString&)> > send_funcs;
};

#endif //DKEvents_H