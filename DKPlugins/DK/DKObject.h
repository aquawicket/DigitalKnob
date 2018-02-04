//// http://blog.noctua-software.com/object-factory-c++.html

#pragma once
#ifndef DKObject_H
#define DKObject_H

#include <map> //std::map
#include "DKLog.h"
#include <iostream>


//////////////
class DKObject
{
public:
	
	~DKObject(){ /*DKEvent::RemoveEvents(this);*/ }	
	virtual bool Init(){ return true; }
	virtual bool End(){ return true; }

	DKStringArray data; //(class,id,var1,var2,var3,etc)

	//////////////////////////////////////////
	virtual void SetData(const DKString& data)
	{
		DKLog("DKObject::SetData("+data+")\n", DKDEBUG);
		
		toStringArray(this->data, data, ",");
	}
};


///////////////////////////
template <class T, class R>
class DKBaseT
{	
public:

	/////////////////////////////////////////
	static void SetName(const DKString& name)
    {
		DKLog("DKObject::SetName("+name+")\n", DKDEBUG);
		
#ifdef WIN32
		if(!classname){ classname = _strdup(name.c_str()); }
#else
		if(!classname){ classname = strdup(name.c_str()); }
#endif
	}

	///////////////////////
	static void Singleton()
    {
		DKLog("DKObject::Singleton()\n", DKDEBUG);
		singleton = true;
		instances.clear();
	}

	////////////////////////////////////////
	static T* Instance(const DKString& data)
    {
		//DKLog("DKObject::Instance("+data+")\n", DKDEBUG);
		//if(has(data, ".js")){
		//	DKLog("DKObject::Instance(): this is a .js file. Can't work for Cef.\n", DKERROR);
		//}
		
		//data = (id,var1,var2,var3,etc)
		if(!instances.empty() && singleton){
			//DKLog("DKClass singleton already created as "+instances[0]->data[0]+"\n", DKWARN);
			return instances[0];
		}

		DKString name(classname);
		//DKLog("DKBaseT::classname = "+name+" \n", DKDEBUG);
		 
 		DKStringArray arry;
		toStringArray(arry,data,",");
		if(!same(arry[0],name)){
			arry.insert(arry.begin(),name);
		}

		if(arry.size() < 2){ //if no id, create empty arry[1]
			arry.push_back("");
		}

		if(arry[1].empty()){ //if empty, Create the id (i.e.  DKPlugin0)
			arry[1] = arry[0];
			int num = 0;
			while(Valid(arry[1]+toString(num))){
				num++;
			}
			arry[1] = arry[1]+toString(num);
		}
		DKString final_data = toString(arry,",");
		//ArrayToString(arry, final_data, ",");

		for(unsigned int i=0; i<instances.size(); ++i){
			if(same(arry[1], instances[i]->data[1])){
				return instances[i]; //The instance id was found, return the object instance
			}
		}

		//Create a new insance
		DKLog("DKObject::Instance("+final_data+")\n", DKDEBUG);
		instances.push_back(new R);
		instance_count = instances.size();
		instances[instances.size()-1]->SetData(final_data); 
		if(!instances[instances.size()-1]->Init()){
			DKLog("DKBaseT::Instance("+final_data+"): failed\n", DKERROR);
			//FIXME - We should we delete the instance. From here or by calling End();
		}
		return instances[instances.size()-1];
	}

	/////////////////////////////////////
	static void Close(const DKString& id)
	{
		DKLog("DKObject::Close("+id+")\n", DKDEBUG);
		
		//if(id.empty()){ return; }
		for(unsigned int i = instances.size() - 1; i >= 0 && i < instances.size(); --i) {
			if(id.empty() || same(id, instances[i]->data[1])){
				//if(has(id,"/")){
				//	DKLog("Close(): "+id+" contains a / \n",DKERROR);
				//}
				//DKLog("Closing "+id+"\n", DKINFO);
				if(instances.size() == 0) { return; }
				//DKLog("Closing "+DKString(classname)+"::"+instances[i]->data[1]+"\n", DKDEBUG);
				if(!instances[i]->End()){
					DKLog("DKBaseT::Close("+id+"): failed\n", DKERROR);
				}
				if(instances.size() == 0) { return; }
				instances[i] = NULL;
				instances.erase(instances.begin()+i);
				instance_count = instances.size();
			}
		}
	}

	/////////////////////////////////////
	static bool Valid(const DKString& id)
	{
		//DKLog("DKObject::Valid("+id+")\n", DKDEBUG);
		
		for(unsigned int i=0; i<instances.size(); ++i){
			if(same(id, instances[i]->data[1])){
				if(instances[i]){ 
					return true;
				}
			}
		}

		return false;
	}

	/////////////////////////////////
	static T* Get(const DKString& id)
	{
		DKLog("DKObject::Get("+id+")\n", DKDEBUG);
		
		for(unsigned int i=0; i<instances.size(); ++i){
			if(id.empty() || same(id, instances[i]->data[1])){
				if(instances[i]){ 
					return instances[i];
				}
			}
		}
		DKLog("DKObject::Get("+id+"): could not find instance \n", DKERROR);
		return 0;
	}

	/////////////////////////////////////////////
	static void GetInstances(DKStringArray& list)
	{
		DKLog("DKObject::GetInstances(DKStringArray&)\n", DKDEBUG);
		
		for(unsigned int i=0; i<instances.size(); ++i){
			if(instances[i]->data.size() > 2){
				list.push_back(instances[i]->data[0]+","+instances[i]->data[1]+","+instances[i]->data[2]);
			}
			else{
				list.push_back(instances[i]->data[0]+","+instances[i]->data[1]);
			}
		}
	}

	/////////////////////////////////////////////////////
	static void GetInstances(std::vector<T*>& _instances)
	{
		DKLog("DKObject::GetInstances(std::vector<T*>&)\n", DKDEBUG);
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
//////////////////////////////////////////////////////
class DKObjectT : public DKObject, public DKBaseT<T,T>
{	

};

#endif //DKObject_H