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

//// http://blog.noctua-software.com/object-factory-c++.html
#pragma once
#ifndef DKClass_H
#define DKClass_H

#include "DK/DKObject.h"
#include "DK/DKUtil.h"

#ifdef __has_include
#	if __has_include(<functional>)
#		include <functional>
		typedef std::function<bool(const void*, void*)> DKFunction;
		typedef std::map<DKString, DKFunction> DKFunctionMap;
		namespace dk_placeholders = std::placeholders;
#	elif __has_include(<boost/function.hpp>) && __has_include(<boost/bind/bind.hpp> && __has_include(<map>)
		#include <boost/function.hpp>
		#include <boost/bind/bind.hpp>
		#include <map> //std::map
		typedef boost::function<bool(const void*, void*)> DKFunction;
		typedef std::map<DKString, DKFunction> DKFunctionMap;
		namespace dk_placeholders = boost::placeholders;
#	else
		static_assert(false, "No ::Function or ::Bind interface available");
#	endif
#else
	static_assert(false, "__has_include not supported");
#endif


typedef enum { non_singleton, singleton } classtype; //make a simple switch with a label

class DKObject;
class DKClass{
public:
	//from DKObject
	virtual void Singleton() = 0;
	virtual DKObject* Instance(const DKString& data) = 0;
	virtual DKObject* Get(const DKString& id) = 0;
	virtual bool Valid(const DKString& id) = 0;
	virtual void Close(const DKString& id) = 0;
	virtual void GetInstances(DKStringArray& list) = 0;

	//for Global functions
	static DKObject* _Instance(const DKString& data);
	static DKObject* _Get(const DKString& data);
	static bool _Valid(const DKString& data);
	static bool _Available(const DKString& data);
	static void _Close(const DKString& data);

	static void Register(const DKString& name, DKClass* _class, bool _singleton);
	static void CloseAll();
	static void GetClassList(DKStringArray& list);
	static void GetObjects(DKStringArray& list);
	static std::map<DKString, DKClass*>* classes;
    static DKFunctionMap* functions;

	/////  GLOBAL FUNCTIONS //////////////////////////////
	static DKObject* DKCreate(const DKString& data){
		DKDEBUGFUNC(data); //data = (class,id,var1,var2,var3,etc)
		return DKClass::_Instance(data);
	}

	static DKObject* DKGet(const DKString& data){
		DKDEBUGFUNC(data); //data = (class,id)
		return DKClass::_Get(data);
	}

	static bool DKValid(const DKString& data){
		//DKDEBUGFUNC(data); //data = (class,id)    // EXCESSIVE LOGGING
		return DKClass::_Valid(data);
	}

	static bool DKAvailable(const DKString& data){
		DKDEBUGFUNC(data); //data = (class,id)
		return DKClass::_Available(data);
	}

	static void DKClose(const DKString& data){
		DKDEBUGFUNC(data); //data = (class,id)
		DKClass::_Close(data);
	}

	template<class T>
    static bool RegisterFunc(const DKString& name, bool (T::*func) (const void*, void*), T* _this){
		DKDEBUGFUNC(name);//, func, _this);
        if(!functions)
            functions = new DKFunctionMap();
        if(HasFunc(name))
            return DKERROR(name+"() function already registered\n");
		//functions[name] = std::bind(func, _this, dk_placeholders::_1, dk_placeholders::_2); //as variable
        (*functions)[name] = std::bind(func, _this, dk_placeholders::_1, dk_placeholders::_2); //as pointer
        if(!HasFunc(name))
            return DKERROR("failed to register "+name+"() function \n");
        return true;
	}
    
	static bool UnregisterFunc(const DKString& name){
		DKDEBUGFUNC(name);
		if(!HasFunc(name))
			return DKERROR(name+"() function not registered \n");
		functions->erase(name);
        if(HasFunc(name))
			return DKERROR("failed to unregister "+name+"() function \n");
		return true;
	}

	static bool HasFunc(const DKString& name){
		DKDEBUGFUNC(name);
		if(!functions)
			return false;
		if(functions->empty())
			return false;
		if(functions->find(name) == functions->end())
			return false;
		return true;
		//return (bool)(*functions)[name];
	}
	
	static bool CallFunc(const DKString& name, const void* input = NULL, void* output = NULL){
		DKDEBUGFUNC(name);//, input, output); //excessive logging
		//if(!(*functions)[name])
		if(!HasFunc(name))
			return DKERROR(name+"() function not registered \n");
		return (*functions)[name](input, output);
	}
};


////////////  GLOBAL CLASS REGISTER //////////////
#define REGISTER_OBJECT(klass, is_singleton) \
    class klass##Class : public DKClass { \
    public: \
        klass##Class(){ \
            DKClass::Register(#klass, this, is_singleton); \
			klass::SetName(#klass); \
        } \
		virtual void Singleton(){ \
			klass::Singleton(); \
        } \
        virtual DKObject* Instance(const DKString& data){ \
			return klass::Instance(data); \
        } \
		virtual DKObject* Get(const DKString& id){ \
			return klass::Get(id); \
        } \
		virtual bool Valid(const DKString& id){ \
			return klass::Valid(id); \
        } \
		virtual void Close(const DKString& id){ \
			klass::Close(id); \
        } \
		virtual void GetInstances(DKStringArray& list){ \
			klass::GetInstances(list); \
        } \
    }; \
static klass##Class global_##klass##Class;

#endif //DKClass_H
