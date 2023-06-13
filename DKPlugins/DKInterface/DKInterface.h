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
	}
	virtual ~DKInterface(){}
	
	DKString interfaceName = "";
	DKString interfaceAddress = "";
	
	
	////// toString //////
	//virtual operator std::string() const { return "[object Interface]"; }
	virtual operator std::string() const { return "null"; }
};


#endif //DKInterface_H