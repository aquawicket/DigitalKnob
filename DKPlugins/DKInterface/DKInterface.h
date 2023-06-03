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



class DKInterface
{
public:
	DKInterface(){
		DKDEBUGFUNC();
	}
	virtual ~DKInterface(){}
	
	DKString interfaceName = "";
	DKString interfaceAddress = "";
};


#endif //DKInterface_H