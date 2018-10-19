//// http://blog.noctua-software.com/object-factory-c++.html
//
//   Note: Only DKObject's can be registered classes

#pragma once
#ifndef DKClass_H
#define DKClass_H
#include <boost/function.hpp>
#include <boost/bind.hpp>
#include "DKObject.h"

class DKObject;


/////////////
class DKClass
{
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

	static void Register(const DKString& name, DKClass* _class, bool singleton);
	static void CloseAll();
	static void GetClassList(DKStringArray& list);
	static void GetObjects(DKStringArray& list);
	static std::map<DKString, DKClass*>* classes;



	/////  GLOBAL FUNCTIONS ////////////////// note: primarily for javascript access
	///////////////////////////////////////////////
	static DKObject* DKCreate(const DKString& data)
	{
		DKDebug(data);
		DKLog("DKCreate("+data+")\n");
		//data = (class,id,var1,var2,var3,etc)
		return DKClass::_Instance(data);
	}

	////////////////////////////////////////////
	static DKObject* DKGet(const DKString& data)
	{
		DKDebug(data);
		//data = (class,id)
		return DKClass::_Get(data);
	}

	/////////////////////////////////////////
	static bool DKValid(const DKString& data)
	{
		DKDebug(data);
		//data = (class,id)
		return DKClass::_Valid(data);
	}

	/////////////////////////////////////////////
	static bool DKAvailable(const DKString& data)
	{
		DKDebug(data);
		//data = (class,id)
		return DKClass::_Available(data);
	}

	/////////////////////////////////////////
	static void DKClose(const DKString& data)
	{
		DKDebug(data);
		//data = (class,id)
		DKClass::_Close(data);
	}

	template<class T>
	//////////////////////////////////////////////////////////////////////////////////////////////
	static void RegisterFunc(const DKString& name, bool (T::*func) (const void*, void*), T* _this)
	{
		//DKLog("DKClass::RegisterFunc("+name+")\n", DKDEBUG);
		DKDebug(name, func, _this);
		functions[name] = boost::bind(func, _this, _1, _2);
		if(!functions[name]){
			DKLog("RegisterFunc(" + name + "): failed to register function \n", DKERROR);
			return;
		}
	}

	////////////////////////////////////////////////
	static void UnregisterFunc(const DKString& name)
	{
		//DKLog("DKClass::UnregisterFunc("+name+")\n", DKDEBUG);
		DKDebug(name);
		functions.erase(name);
		if(functions[name]) {
			DKLog("UnegisterFunc("+name+"): failed to unregister function \n", DKERROR);
			return;
		}
	}

	/////////////////////////////////////////
	static bool HasFunc(const DKString& name)
	{
		DKDebug(name);
		if(!functions[name]){ 
			return false;
		}
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////////
	static bool CallFunc(const DKString& name, const void* input, void* output)
	{
		DKDebug(name, input, output);
		if(!functions[name]){ 
			DKLog("CallFunc("+name+") not registered\n", DKWARN);
			return false;
		}
		return functions[name](input, output);
	}

	static std::map<DKString, boost::function<bool (const void*, void*)> > functions;
};



/////  GLOBAL CLASS REGISTER //////////////
#define REGISTER_OBJECT(klass, singleton) \
    class klass##Class : public DKClass { \
    public: \
        klass##Class() \
        { \
            DKClass::Register(#klass, this, singleton); \
			klass::SetName(#klass); \
        } \
		virtual void Singleton() \
		{ \
			klass::Singleton(); \
        } \
        virtual DKObject* Instance(const DKString& data) \
		{ \
			return klass::Instance(data); \
        } \
		virtual DKObject* Get(const DKString& id) \
		{ \
			return klass::Get(id); \
        } \
		virtual bool Valid(const DKString& id) \
		{ \
			return klass::Valid(id); \
        } \
		virtual void Close(const DKString& id) \
		{ \
			klass::Close(id); \
        } \
		virtual void GetInstances(DKStringArray& list) \
		{ \
			klass::GetInstances(list); \
        } \
    }; \
static klass##Class global_##klass##Class;


#endif //DKClass_H