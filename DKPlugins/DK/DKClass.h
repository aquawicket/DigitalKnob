//// http://blog.noctua-software.com/object-factory-c++.html
#pragma once
#ifndef DKClass_H
#define DKClass_H

#include "DKObject.h"
#include "DKUtil.h"

#define STD_FUNCTION //or BOOST_FUNCTION
#ifdef STD_FUNCTION
    #include <functional>
    typedef std::function<bool(const void*, void*)> DKFunction;
    typedef std::map<DKString, DKFunction> DKFunctionMap;
    namespace dk_placeholders = std::placeholders;
#elif defined (BOOST_FUNCTION)
    #include <boost/function.hpp>
    #include <boost/bind/bind.hpp>
    typedef boost::function<bool(const void*, void*)> DKFunction;
    namespace dk_placeholders = boost::placeholders;
#else
    DKERROR("No ::Function or ::Bind interface available");
#endif



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

	static void Register(const DKString& name, DKClass* _class, bool singleton);
	static void CloseAll();
	static void GetClassList(DKStringArray& list);
	static void GetObjects(DKStringArray& list);
	static std::map<DKString, DKClass*>* classes;
    static DKFunctionMap* functions;

	/////  GLOBAL FUNCTIONS ////////////////// note: primarily for javascript access
	static DKObject* DKCreate(const DKString& data){
		DKDEBUGFUNC(data); //data = (class,id,var1,var2,var3,etc)
		return DKClass::_Instance(data);
	}

	static DKObject* DKGet(const DKString& data){
		DKDEBUGFUNC(data); //data = (class,id)
		return DKClass::_Get(data);
	}

	static bool DKValid(const DKString& data){
		//DKDEBUGFUNC(data); //data = (class,id)
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
		DKDEBUGFUNC(name, func, _this);
        //functions[name] = std::bind(func, _this, dk_placeholders::_1, dk_placeholders::_2); //member variable version
        if(!functions)
            functions = new DKFunctionMap();
        if((*functions)[name])
            DKERROR("RegisterFunc(" + name + "): failed to register function \n");
        (*functions)[name] = std::bind(func, _this, dk_placeholders::_1, dk_placeholders::_2); //member pointer version
        if(!(*functions)[name])
            return DKERROR("RegisterFunc("+name+"): failed to register function \n");
        return true;
	}
    

	static bool UnregisterFunc(const DKString& name){
		DKDEBUGFUNC(name);
		functions->erase(name);
        if((*functions)[name])
			return DKERROR("UnegisterFunc("+name+"): failed to unregister function \n");
		return true;
	}

	static bool HasFunc(const DKString& name){
		DKDEBUGFUNC(name);
		return (bool)(*functions)[name];
	}
	
	static bool CallFunc(const DKString& name, const void* input = NULL, void* output = NULL){
		//DKDEBUGFUNC(name, input, output); //excessive logging
		if(!(*functions)[name])
			return DKERROR("CallFunc("+name+") not registered\n");
		return (*functions)[name](input, output);
	}
};


/////  GLOBAL CLASS REGISTER //////////////
#define REGISTER_OBJECT(klass, singleton) \
    class klass##Class : public DKClass { \
    public: \
        klass##Class(){ \
            DKClass::Register(#klass, this, singleton); \
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
