#pragma once
#ifndef dk_objAddress
#define dk_objAddress

#include "DK.hpp"
#include <string>
#include <iostream>
#include <sstream>

bool same(const std::string& str, const std::string& str2);
static void* addressToObject(const std::string& address);
static std::string objectToAddress(void* element);


#endif //dk_objAddress