//// http://blog.noctua-software.com/object-factory-c++.html
#pragma once
#ifndef DKObject_H
#define DKObject_H

#include <map> //std::map
#include "DKLog.h"
#include <iostream>

class DKObject{
public:
	~DKObject(){ 
		/*DKEvent::RemoveEvents(this);*/ 
	}	
	virtual bool Init(){ 
		return true; 
	}
	virtual bool End(){ 
		return true; 
	}
	DKStringArray data; //(class,id,var1,var2,var3,etc)
	virtual void SetData(const DKString& data){
		DKDEBUGFUNC(data);
		toStringArray(this->data, data, ",");
	}
};

template <class T, class R>
class DKBaseT{	
public:
	static void SetName(const char* name){
		DKDEBUGFUNC(name);
		if(!classname)
			classname = (char*)name;
	}
	static void Singleton(){
		DKDEBUGFUNC();
		singleton = true;
		instances.clear();
	}
	static T* Instance(const DKString& data){
		//DKDEBUGFUNC(data);
		//if(has(data, ".js"))
		//	DKERROR("DKObject::Instance(): this is a .js file. Can't work for Cef\n");
		//data = (id,var1,var2,var3,etc)
		if(!instances.empty() && singleton){
			//DKWARN("DKClass singleton already created as "+instances[0]->data[0]+"\n");
			return instances[0];
		}
		DKString name(classname);
		//DKINFO("DKBaseT::classname = "+name+"\n");
 		DKStringArray arry;
		toStringArray(arry,data,",");
		if(!same(arry[0],name))
			arry.insert(arry.begin(),name);
		if(arry.size() < 2) //if no id, create empty arry[1]
			arry.push_back("");
		if(arry[1].empty()){ //if empty, Create the id (i.e.  DKPlugin0)
			arry[1] = arry[0];
			int num = 0;
			while(Valid(arry[1]+toString(num)))
				num++;
			arry[1] = arry[1]+toString(num);
		}
		DKString final_data = toString(arry,",");
		//ArrayToString(arry, final_data, ",");
		for(unsigned int i=0; i<instances.size(); ++i){
			if(same(arry[1], instances[i]->data[1]))
				return instances[i]; //The instance id was found, return the object instance
		}
		//Create a new insance
		//DKINFO("DKObject::Instance("+final_data+")\n");
		instances.push_back(new R);
		instance_count = instances.size();
		instances[instances.size()-1]->SetData(final_data); 
		if(!instances[instances.size()-1]->Init()){
			DKWARN("DKBaseT::Instance("+final_data+"): failed\n");
			//TEST - We should delete the instance.
			//Close(arry[1]);
			//return NULL;
		}
		return instances[instances.size()-1];
	}
	static void Close(const DKString& id = ""){
		DKDEBUGFUNC(id);		
		//if(id.empty()){ return; }
		for(unsigned int i = instances.size() - 1; i >= 0 && i < instances.size(); --i) {
			if(id.empty() || same(id, instances[i]->data[1])){
				//if(has(id,"/"))
				//	DKERROR("Close(): "+id+" contains a /\n");
				//DKINFO("Closing "+id+"\n");
				if(instances.size() == 0)
					return;
				//DKINFO("Closing "+DKString(classname)+"::"+instances[i]->data[1]+"\n");
				if(!instances[i]->End())//FIXME - this can crash if End() does not exits in the instance. 
					DKWARN("DKBaseT::Close("+id+"): failed\n");
				if(instances.size() == 0)
					return;
				instances[i] = NULL;
				instances.erase(instances.begin()+i);
				instance_count = instances.size();
			}
		}
	}
	static bool Valid(const DKString& id = ""){
		//DKDEBUGFUNC(id);
		for(unsigned int i=0; i<instances.size(); ++i){
			if(same(id, instances[i]->data[1])){
				if(instances[i])
					return true;
			}
		}
		return false;
	}
	static T* Get(const DKString& id = ""){
		DKDEBUGFUNC(id);
		for(unsigned int i=0; i<instances.size(); ++i){
			if(id.empty() || same(id, instances[i]->data[1])){
				if(instances[i])
					return instances[i];
			}
		}
		DKERROR("DKObject::Get("+id+"): could not find instance \n");
		return 0;
	}
	static void GetInstances(DKStringArray& list){
		DKDEBUGFUNC();
		/*
		if(list.empty())
			return DKWARN("DKObject::GetInstances(): list is empty\n");
		*/
		for(unsigned int i=0; i<instances.size(); ++i){
			if(instances[i]->data.size() > 2)
				list.push_back(instances[i]->data[0]+","+instances[i]->data[1]+","+instances[i]->data[2]);
			else
				list.push_back(instances[i]->data[0]+","+instances[i]->data[1]);
		}
	}
	static void GetInstances(std::vector<T*>& _instances){
		DKDEBUGFUNC();
		_instances = instances;
	}
	static int instance_count;
private:
	static std::vector<T*> instances;
	static char* classname;
    static bool singleton;
};

template<class T, class R>	char* DKBaseT<T,R>::classname;
template<class T, class R>	int DKBaseT<T,R>::instance_count;
template<class T, class R>	bool DKBaseT<T,R>::singleton;
template<class T, class R>	std::vector<T*> DKBaseT<T,R>::instances;
template <class T>
class DKObjectT : public DKObject, public DKBaseT<T,T>{};

#endif //DKObject_H