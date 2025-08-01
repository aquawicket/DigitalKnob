#pragma once
#ifndef dk_replaceAll_h
#define dk_replaceAll_h

#include <algorithm>
#include <string>
#include "DK.hpp"
#include "dk_echo.hpp"
#include "dk_error.hpp"


//################################################################################
//# dk_replaceAll(str, find, replace, output)
//#
//#		Reference: https://stackoverflow.com/a/32496721
//#
//# You must free the result if result is non-NULL.
int dk_replaceAll(std::string& str, const std::string& from, const std::string& to, std::string& output) {
    if(from.empty())
        return 0;
    size_t start_pos = 0;
    while((start_pos = str.find(from, start_pos)) != std::string::npos) {
        str.replace(start_pos, from.length(), to);
        start_pos += to.length(); // In case 'to' contains 'from', like replacing 'x' with 'yx'
    }
	output = str;
	return 0;
}


#endif //dk_replaceAll_hpp