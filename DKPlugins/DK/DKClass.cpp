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

#include "DK/stdafx.h"
#include "DK/DKClass.h"

std::map<DKString, DKClass*>* DKClass::classes = NULL;
DKFunctionMap* DKClass::functions = NULL;

void DKClass::Register(const DKString& klass, DKClass* _class, bool _singleton){
	DKDEBUGFUNC(klass, _class, _singleton);
	if(!classes){ classes = new std::map<DKString, DKClass*>(); }
	if((*classes)[klass])
		return;  //already exists
	(*classes)[klass] = _class;
	if(_singleton)
		(*classes)[klass]->Singleton();
}

DKObject* DKClass::_Instance(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if(has(arry[0],".html"))
		arry.insert(arry.begin(),"DKWidget");
	else if(has(arry[0],".js"))
		arry.insert(arry.begin(),"DKJavascript");
	else if(has(arry[0],".css"))
		arry.insert(arry.begin(),"DKRmlCss");
	if(classes && (*classes)[arry[0]]){
		//data = (class,id,var1,var2,etc)
		if(arry.size() > 1)
			return (*classes)[arry[0]]->Instance(data);
		return (*classes)[arry[0]]->Instance("");
	}
	DKWARN(arry[0]+" not registered\n");
	//DKWARN("   to include, add dk_depend("+arry[0]+") to DKMAKE.cmake, and rebuild\n");
	return NULL;
}

DKObject* DKClass::_Get(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if(classes && (*classes)[arry[0]]){
		if(arry.size() < 2)
			DKINFO("arry.size() < 2,  we should return the first instance\n");
		return (*classes)[arry[0]]->Get(arry[1]);
	}
	DKWARN(arry[0]+" not registered\n");
	//DKWARN("   to include, add dk_depend("+arry[0]+") to DKMAKE.cmake, and rebuild\n");
	return NULL;
}

bool DKClass::_Valid(const DKString& data){
	//DKDEBUGFUNC(data);  // EXCESSIVE LOGGING
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if(classes && (*classes)[arry[0]]){
		if(arry.size() < 2)
			DKWARN("arry.size() < 2,  we should return the first instance\n");
		return (*classes)[arry[0]]->Valid(arry[1]);
	}
	//DKLOG("DKClass::_Valid(): "+arry[0]+" not registered\n", DKWARN);
	//DKWARN("   to include, add dk_depend("+arry[0]+") to DKMAKE.cmake, and rebuild\n");
	return false;
}

bool DKClass::_Available(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if(classes && (*classes)[arry[0]]){
		if(arry.size() < 2)
			DKDEBUG("arry.size() < 2, we should see if we can create an instance\n");
		if(arry.size() > 1 && (*classes)[arry[0]]->Valid(arry[1])){
			DKWARN("DKClass: "+arry[0]+","+arry[1]+" - id is already in use\n");
			return false;
		}
		return true;
	}
	//DKWARN("DKClass::_Available(): "+arry[0]+" not registered\n");
	//DKWARN("   to include, add dk_depend("+arry[0]+") to DKMAKE.cmake, and rebuild\n");
	return false;
}

void DKClass::_Close(const DKString& data){
	DKDEBUGFUNC(data);
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if(has(arry[0],".html"))
		arry.insert(arry.begin(),"DKWidget");
	else if(has(arry[0],".js"))
		arry.insert(arry.begin(),"DKJavascript");
	else if(has(arry[0],".css")){
		arry.insert(arry.begin(),"DKCss");
		return;
	}
	if(classes && (*classes)[arry[0]]){
		if(arry.size() > 1){
			if((*classes)[arry[0]]->Valid(arry[1]))
				(*classes)[arry[0]]->Close(arry[1]);
		}
		else
			(*classes)[arry[0]]->Close("");
	}
}

void DKClass::CloseAll(){
	DKDEBUGFUNC();
	std::map<DKString, DKClass*>::reverse_iterator rit;
	if(!classes)
		return;
	for(rit = (*classes).rbegin(); rit != (*classes).rend(); ++rit){
		if((*classes)[rit->first]){
			DKINFO("Closing " + rit->first + "\n");
			(*classes)[rit->first]->Close("");
		}
	}
#if WIN
		if(IsWindowVisible(GetConsoleWindow()))
			ShowWindow(GetConsoleWindow(),SW_HIDE);
#endif
}

void DKClass::GetClassList(DKStringArray& list){
	DKDEBUGFUNC(list);
	std::map<DKString, DKClass*>::reverse_iterator rit;
	if(!classes)
		return;
	for (rit = (*classes).rbegin(); rit != (*classes).rend(); ++rit){
		if ((*classes)[rit->first])
			list.push_back(rit->first);
	}
}

void DKClass::GetObjects(DKStringArray& list){
	DKDEBUGFUNC(list);
	list.clear();
	std::map<DKString, DKClass*>::iterator it;
	if(!classes)
		return;
	for(it = (*classes).begin(); it != (*classes).end(); ++it){
		if((*classes)[it->first])
			(*classes)[it->first]->GetInstances(list);
	}
}
