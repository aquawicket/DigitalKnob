#pragma once
#ifndef dk_objAddress
#define dk_objAddress

#include "DK.hpp"
#include <string>
#include <iostream>
#include <sstream>

//################################################################################
//# same(str, str2)
//#
bool same(const std::string& str, const std::string& str2);

//################################################################################
//# addressToObject(address)
//#
static void* addressToObject(const std::string& address);

//################################################################################
//# objectToAddress(element)
//#
static std::string objectToAddress(void* object);

#endif //dk_objAddress