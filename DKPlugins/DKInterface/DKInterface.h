#pragma once
#ifndef DKInterface_H
#define DKInterface_H

#include "DK/DK.h"

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
		DKDEBUGFUNC();
		interfaceName = "Interface";
		interfaceAddress = pointerToAddress(this);
		address[interfaceName] = pointerToAddress(this);
		DKINFO("\nDKInterface("+interfaceAddress+") \n");
		
		/*
		for(unsigned int i=0; i<_list.size(); ++i){
			if(interfaceAddress == _list[i])
				return;
			_list.push_back(interfaceAddress);
		}
		*/
	}
	virtual ~DKInterface(){}
	
	//std::vector<DKString> _list;
	DKString interfaceName = "";
	DKString interfaceAddress = "";
	std::map<DKString, DKString> address;
	
	
	////// toString //////
	operator std::string() const { return "[object Interface]"; }
};


class DKNullInterface : public DKInterface
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKInterface_H