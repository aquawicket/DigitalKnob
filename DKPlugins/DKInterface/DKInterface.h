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
		DKINFO("DKInterface("+interfaceAddress+") \n");
	}
	virtual ~DKInterface(){}
	
	DKString interfaceName = "";
	DKString interfaceAddress = "";
	
	
	////// toString //////
	operator std::string() const { return "[object Interface]"; }
};


class DKNullInterface : public DKInterface
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKInterface_H