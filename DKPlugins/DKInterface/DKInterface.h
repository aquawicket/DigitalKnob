#pragma once
#ifndef DKInterface_H
#define DKInterface_H

#include "DK/DK.h"
#include <unordered_map>

////// undefined //////
typedef void undefined;

////// DOMString //////
typedef std::string DOMString;

////// USVString //////
typedef std::string USVString;

////// CSSOMString //////
typedef std::string CSSOMString;


class DKInterface
{
public:
	DKInterface(){
		//DKDEBUGFUNC();
		//cleanInterfaceList();
		
		interfaceName = "Interface";
		interfaceAddress = pointerToAddress(this);
		address[interfaceName] = pointerToAddress(this);
		DKINFO("\nDKInterface("+interfaceAddress+") \n");
		
		_list.push_back(this);
		//printInterfaceList();
	}
	virtual ~DKInterface(){
		for(unsigned int i=0; i<_list.size(); ++i){
			if(_list[i] == this)
			    _list.erase(_list.begin() + i);
		}
	}
	
	static std::vector<DKInterface*> _list;
	DKString interfaceName = "";
	DKString interfaceAddress = "";
	std::unordered_map<DKString, DKString> address;
	//std::vector<std::pair<DKString, DKString>> address;
	
	static void printInterfaceList(){
		DKINFO("\n########## Interface List ##########\n");
		for(unsigned int i=0; i<_list.size(); ++i){
			DKINFO(toString(i)+": "+_list[i]->interfaceName+"("+_list[i]->interfaceAddress+"): ");	//print interfaceName and interfaceAddress
			
			for (auto nn = _list[i]->address.begin(); nn != _list[i]->address.end(); nn++)
				std::cout << nn->first << ", ";
			
			DKINFO("\n");
		}
		DKINFO("\n");
	}
	
	/*
	static void cleanInterfaceList(){
		for(unsigned int i=0; i<_list.size(); ++i){
			if(_list[i]->interfaceName.empty())
			    _list.erase(_list.begin() + i);
		}
	}
	*/
	
	////// toString //////
	operator std::string() const { return "[object "+interfaceName+"]"; }
	//friend std::ostream& operator<<(std::ostream& os, const DKInterface&/* interface*/){
    //    os << "[object "+interfaceName+"]";
    //    return os;
	//}
};


#endif //DKInterface_H