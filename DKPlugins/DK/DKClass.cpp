#include "DK/stdafx.h"
#include "DKClass.h"

std::map<DKString, DKClass*>* DKClass::classes = NULL;
std::map<DKString, boost::function<bool (const void*, void*)> > DKClass::functions;

void DKClass::Register(const DKString& klass, DKClass* _class, bool singleton){
	DKDEBUGFUNC(klass, _class, singleton);
	if(!classes){ classes = new std::map<DKString, DKClass*>(); }
	if((*classes)[klass]){ return; } //already exists
	(*classes)[klass] = _class;
	if(singleton)
		(*classes)[klass]->Singleton();
}

DKObject* DKClass::_Instance(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");

	if(has(arry[0],".html")){
		arry.insert(arry.begin(),"DKWidget");
	}
	else if(has(arry[0],".js")){
		arry.insert(arry.begin(),"DKJavascript");
	}
	else if(has(arry[0],".css")){
		arry.insert(arry.begin(),"DKCss");
	}

	if((*classes)[arry[0]]){
		//data = (class,id,var1,var2,etc)
		if(arry.size() > 1){
			return (*classes)[arry[0]]->Instance(data);
		}
		return (*classes)[arry[0]]->Instance("");
	}

	DKWARN("DKClass::_Instance "+arry[0]+" not registered\n");
	//DKWARN("   Open DKCMake.txt and add DKDEPEND("+arry[0]+"), and rebuild\n");
	return NULL;
}

DKObject* DKClass::_Get(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if((*classes)[arry[0]]){
		if(arry.size() < 2){
			DKINFO("DKClass::_Get("+data+"): arry.size() < 2,  we should return the first instance\n");
		}
		return (*classes)[arry[0]]->Get(arry[1]);
	}

	DKWARN("DKClass::_Get(): "+arry[0]+" not registered\n");
	//DKWARN("   Open DKCMake.txt and add DKDEPEND("+arry[0]+"), and rebuild\n");
	return NULL;
}

bool DKClass::_Valid(const DKString& data){
	//DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if((*classes)[arry[0]]){
		if(arry.size() < 2){
			DKWARN("DKClass::_Valid("+data+"): arry.size() < 2,  we should return the first instance\n");
		}
		return (*classes)[arry[0]]->Valid(arry[1]);
	}

	//DKLOG("DKClass::_Valid(): "+arry[0]+" not registered\n", DKWARN);
	//DKLOG("   Open DKCMake.txt and add DKDEPEND("+arry[0]+"), and rebuild\n", DKWARN);
	return NULL;
}

bool DKClass::_Available(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if((*classes)[arry[0]]){
		if(arry.size() < 2){
			DKDEBUG("DKClass::_Available("+data+"): arry.size() < 2, we should see if we can create an instance\n");
		}
		if(arry.size() > 1 && (*classes)[arry[0]]->Valid(arry[1])){
			DKWARN("DKClass: "+arry[0]+","+arry[1]+" - id is already in use\n");
			return false;
		}
		return true;
	}

	//DKWARN("DKClass::_Available(): "+arry[0]+" not registered\n");
	//DKWARN("   Open DKCMake.txt and add DKDEPEND("+arry[0]+"), and rebuild\n");
	return false;
}

void DKClass::_Close(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if(has(arry[0],".html")){
		arry.insert(arry.begin(),"DKWidget");
	}
	else if(has(arry[0],".js")){
		arry.insert(arry.begin(),"DKJavascript");
	}
	else if(has(arry[0],".css")){
		arry.insert(arry.begin(),"DKCss");
		return;
	}

	if((*classes)[arry[0]]){
		if(arry.size() > 1){
			if((*classes)[arry[0]]->Valid(arry[1])){
				(*classes)[arry[0]]->Close(arry[1]);
			}
		}
		else{
			(*classes)[arry[0]]->Close("");
		}
	}
}

void DKClass::CloseAll(){
	DKDEBUGFUNC();
	std::map<DKString, DKClass*>::reverse_iterator rit;
	for(rit = (*classes).rbegin(); rit != (*classes).rend(); rit++){
		if((*classes)[rit->first]){
			//DKLOG("DKClass::CloseAll(): Closing " + rit->first + "\n");
			(*classes)[rit->first]->Close("");
		}
	}
#ifdef WIN32
	if(IsWindowVisible(GetConsoleWindow())){
		ShowWindow(GetConsoleWindow(),SW_HIDE);
	}
#endif
}

void DKClass::GetClassList(DKStringArray& list){
	DKDEBUGFUNC();
	std::map<DKString, DKClass*>::reverse_iterator rit;
	for (rit = (*classes).rbegin(); rit != (*classes).rend(); ++rit){
		if ((*classes)[rit->first]){
			list.push_back(rit->first);
		}
	}
}

/////////////////////////////////////////////
void DKClass::GetObjects(DKStringArray& list)
{
	DKDEBUGFUNC();
	
	list.clear();
	std::map<DKString, DKClass*>::iterator it;
	for(it = (*classes).begin(); it != (*classes).end(); ++it){
		if((*classes)[it->first]){
			(*classes)[it->first]->GetInstances(list);
		}
	}
}
