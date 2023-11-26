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
#include "DK/DKString.h"
#include "DK/DKLog.h"

//WARNING_DISABLE
#include <codecvt> //string <--> wsting conversion
//WARNING_ENABLE


bool same(const DKString& str, const DKString& str2) {
	//DKDEBUGFUNC(str, str2);
	if(str.compare(str2) == 0)
		return true;
	return false;
}

bool samei(const DKString& str, const DKString& str2) {
	//DKDEBUGFUNC(str, str2);
	DKString strA = toLower(str);
	//std::transform(strA.begin(), strA.end(), strA.begin(), [](unsigned char c) {
	//	return static_cast<char>(std::tolower(c));
	//});
	DKString strB = toLower(str2);
	//std::transform(strB.begin(), strB.end(), strB.begin(), [](unsigned char c) {
	//	return static_cast<char>(std::tolower(c));
	//});
	if(same(strA, strB))
		return true;
	return false;
}

bool has(const DKString& search, const DKString& forthis) {
	//DKDEBUGFUNC(search, forthis);
	std::string::size_type found = search.find(forthis);
	if(found != std::string::npos)
		return true;
	return false;
}

int substr_count(const DKString& search, const DKString& forthis) {
	//DKDEBUGFUNC(search, forthis);
	int occurrences = 0;
	std::string::size_type pos = 0;
	while ((pos = search.find(forthis, pos)) != std::string::npos) {
		++occurrences;
		pos += forthis.length();
	}
	return occurrences;
}

DKString toString(const DKString& _str){
		return _str;
}

DKString toString(const int& _int) {
	//DKDEBUGFUNC(_int);
	/*
	DKString s;
	std::stringstream out;
	out << _int;
	s = out.str();
	return s;
	*/
	return std::to_string(_int); //C11
}

DKString toString(const long& _long) {
	//DKDEBUGFUNC(_long);
	/*
	DKString s;
	std::stringstream out;
	out << _long;
	s = out.str();
	return s;
	*/
	return std::to_string(_long); //C11
}

DKString toString(const float& _float) {
	//DKDEBUGFUNC(_float);
	/*
	DKString s;
	std::stringstream out;
	out << _float;
	s = out.str();
	return s;
	*/
	return std::to_string(_float); //C11
}

DKString toString(const double& _double) {
	//DKDEBUGFUNC(_double);
	/*
	DKString s;
	std::stringstream out;
	out << _double;
	s = out.str();
	return s;
	*/
	
	// https://stackoverflow.com/a/13709929/688352
	std::string str = std::to_string(_double); //C11
	str.erase(str.find_last_not_of('0') + 1, std::string::npos); // Strip the 0's trailing after .
	str.erase(str.find_last_not_of('.') + 1, std::string::npos); // Strip the . if whole number
	return str;
}

DKString toString(const unsigned int& _uint) {
	//DKDEBUGFUNC(_uint);
	/*
	DKString s;
	std::stringstream out;
	out << _uint;
	s = out.str();
	return s;
	*/
	return std::to_string(_uint); //C11
}

DKString toString(const unsigned long int& _ulongint) {
	//DKDEBUGFUNC(_ulongint);
	/*
	DKString s;
	std::stringstream out;
	out << _ulongint;
	s = out.str();
	return s;
	*/
	return std::to_string(_ulongint); //C11
}

DKString toString(const unsigned long long int& _ulonglongint) {
	//DKDEBUGFUNC(_ulonglongint);
	/*
	DKString s;
	std::stringstream out;
	out << _ulonglongint;
	s = out.str();
	return s;
	*/
	return std::to_string(_ulonglongint); //C11
}

DKString toString(const bool _bool){
	//DKDEBUGFUNC(_bool);
	if(_bool)
		return "true";
	return "false";
}

DKString toString(const char _char) {
	//DKDEBUGFUNC(_char);
	return std::string(1, _char);
}

DKString toString(const char* _charptr) {
	//DKDEBUGFUNC(_charptr);
	return _charptr;
}

DKString toString(const unsigned char* _uchar) {
	//DKDEBUGFUNC(_uchar);
	return reinterpret_cast<char const*>(_uchar);
}

DKString toString(void* _voidptr) {
	//DKDEBUGFUNC(_voidptr);
	DKString *p = static_cast<DKString*>(_voidptr);
	DKString string = *p;
	return string;
}

// https://stackoverflow.com/a/65863170/688352
// https://riptutorial.com/cplusplus/example/4190/conversion-to-std--wstring
DKString toString(const std::wstring& _wstring) {
	//DKDEBUGFUNC(_wstring);
/*
#if WIN
	int len;
    int slength = (int)_wstring.length();
    len = WideCharToMultiByte(CP_ACP, 0, _wstring.c_str(), slength, 0, 0, 0, 0); 
    std::string s(len, '\0');
    WideCharToMultiByte(CP_ACP, 0, _wstring.c_str(), slength, &s[0], len, 0, 0); 
    return s;
#else
*/
	return std::wstring_convert<std::codecvt_utf8<wchar_t>>().to_bytes(_wstring);
//#endif
}

DKString toString(const DKStringArray& arry, const char* seperator) {
	//DKDEBUGFUNC(arry, seperator);
	DKString string = "";
	for(unsigned int i=0; i<arry.size(); ++i){
		string += arry[i];
		if(i < arry.size()-1)
			string += seperator;
	}
	return string;
}

DKString toLower(const DKString& input) {
	//DKDEBUGFUNC(input);
    DKString output = input;
	std::transform(output.begin(), output.end(), output.begin(), [](unsigned char c) {
		return static_cast<char>(std::tolower(c));
	});
    return output;
}

DKString toUpper(const DKString& input) {
	//DKDEBUGFUNC(input);
    DKString output = input;
	std::transform(output.begin(), output.end(), output.begin(), [](unsigned char c) {
		return static_cast<char>(std::toupper(c));
	});
    return output;
}

#if WIN
DKString toString(const HWND hwnd) {
	//DKDEBUGFUNC(hwnd);
	std::stringstream ss;
	ss << "0x" << hwnd;
	return ss.str();
}
#endif


DKString& rtrim(DKString& s, const char* t) {
	//DKDEBUGFUNC(s, t);
	return s.erase(s.find_last_not_of(t) + 1);
}

DKString& ltrim(DKString& s, const char* t) {
	//DKDEBUGFUNC(s, t);
	return s.erase(0, s.find_first_not_of(t));
}

DKString& trim(DKString& s, const char* t) {
	//DKDEBUGFUNC(s, t);
	return ltrim(rtrim(s, t), t);
}

bool toBool(const DKString& str) {
	//DKDEBUGFUNC(str);
    if(str.empty())
		return false;
	if(str == "false")
		return false;
	if(str == "0")
		return false;
	return true;
}

int toInt(const DKString& str) {
	//DKDEBUGFUNC(str);
	return atoi(str.c_str());
}

long toLong(const DKString& str) {
	//DKDEBUGFUNC(str);
	return atol(str.c_str());
}

float toFloat(const DKString& str) {
	//DKDEBUGFUNC(str);
	return (float)atof(str.c_str());
}

unsigned int toUInt(const DKString& str) {
	//DKDEBUGFUNC(str);
	return atoi(str.c_str());
}

unsigned long int toULong(const DKString& str) {
	//DKDEBUGFUNC(str);
	return strtoul(str.c_str(), NULL, 0);
}

unsigned long long int toULongLong(const DKString& str) {
	//DKDEBUGFUNC(str);
	return strtoull(str.c_str(), NULL, 0);
}

// https://stackoverflow.com/a/65863170/688352
// https://riptutorial.com/cplusplus/example/4190/conversion-to-std--wstring
std::wstring toWString(const DKString& str) {
	//DKDEBUGFUNC(str);
/*
#if WIN
	int len;
	int slength = (int)str.length() + 1;
	len = MultiByteToWideChar(CP_ACP, 0, str.c_str(), slength, 0, 0);
	wchar_t* buf = new wchar_t[len];
	MultiByteToWideChar(CP_ACP, 0, str.c_str(), slength, buf, len);
	std::wstring r(buf);
	delete[] buf;
	return r;
#else
*/
	return std::wstring_convert<std::codecvt_utf8<wchar_t>>().from_bytes(str);
//#endif
}

#if WIN
HWND toHWND(const DKString& str) {
	//DKDEBUGFUNC(str);
	DKString hex = str;
	hex.erase(0,2);
	size_t x;
	std::stringstream ss;
	ss << std::hex << hex;
	ss >> x;
	return (HWND)x;
}
#endif


bool replace(DKString& str, const DKString& oldStr, const DKString& newStr) {
	//DKDEBUGFUNC(str, oldStr, newStr);
	std::string::size_type pos = 0;
	while((pos = str.find(oldStr, pos)) != std::string::npos){
		str.replace(pos, oldStr.length(), newStr);
		pos += newStr.length();
	}
	return true;
}

bool replace_first(DKString& str, const DKString& oldStr, const DKString& newStr) {
	//DKDEBUGFUNC(str, oldStr, newStr);
	std::string::size_type pos = 0;
	if((pos = str.find(oldStr, pos)) != std::string::npos){
		str.replace(pos, oldStr.length(), newStr);
		pos += newStr.length();
	}
	return true;
}


bool IsNumber(const DKString& str) {
	//DKDEBUGFUNC(str);
    std::string::const_iterator it = str.begin();
    while (it != str.end() && std::isdigit(*it)) ++it;
    return !str.empty() && it == str.end();
}

bool Pad(int num, char character, DKString& str) {
	//DKDEBUGFUNC(num, character, str);
	std::ostringstream ss;
	ss << std::setw(num) << std::setfill(character) << str;
	str = ss.str();
	return true;
}

bool RemoveDuplicates(DKStringArray& arry) {
	//DKDEBUGFUNC(arry);
	sort( arry.begin(), arry.end() );
	arry.erase( unique( arry.begin(), arry.end() ), arry.end() );
	return true;
}

bool getSettingFromString(const DKString& filestring, const DKString& setting, DKString& value) {
	//DKDEBUGFUNC(filestring, setting, value);
	//If the variable looks like this: [VARIABLE]
	//then we return everything up to the next [VARIABLE] or to the end of the file.
	if(has(setting,"[") && has(setting,"]")){
		std::string::size_type temp = filestring.find(setting,0);
        if(temp == std::string::npos){return false;}
		std::string::size_type start = filestring.find("]",temp);
		std::string::size_type end = filestring.find("[",start);
		if(end == std::string::npos){end = filestring.size();}
		DKString out = filestring.substr(start+1, end-start-1);
		replace(out,"\r","");
		replace(out,"\n"," ");
		trim(out);
		value = out;
		return true;
	}
	//If the variable looks like this:  VARIABLE 
	//then we return the rest of the line
	DKString string = setting + " ";
	std::string::size_type temp = filestring.find(string,0);
    if(temp == std::string::npos)
		return false;
	std::string::size_type start = filestring.find(" ",temp);
	std::string::size_type end = filestring.find("\n",start);
	DKString out = filestring.substr(start+1, end-start-1);
	replace(out,"\r","");
	replace(out,"\n","");
	trim(out);
	value = out;
	return true;
}

bool toStringArray(DKStringArray& output, const DKString& str, const DKString& seperator) {
	//DKDEBUGFUNC(output, str, seperator);
	DKString text = str + seperator; //add a seperator at the end, or we won't get the last variable
	size_t begin = 0;
	//int end;
	while(1){ //FIXME - while(1) loops are dangerous 
	//while(end != std::string::npos){
		std::string::size_type end = text.find(seperator, begin);
		if(end==std::string::npos)
			return true;
		DKString temp = text.substr(begin, end-begin);
		replace(temp,"\r","");
		replace(temp,"\n"," ");
		replace(temp,seperator,"");
		trim(temp);
		output.push_back(temp);
		begin=end+1;
	}
	if(output[output.size()-1].empty()) //if last one empty
		output.erase(output.begin()+output.size()-1);
	return true;
}

/*
bool ArrayToString(const DKStringArray& arry, DKString& str, const char* seperator) {
	//DKDEBUGFUNC(arry, str, seperator);
	str = "";
	for(unsigned int i=0; i<arry.size(); ++i){
		str += arry[i];
		if(i < arry.size()-1)
			str += seperator;
	}
	return true;
}
*/

/*
DKStringArray getSettingsFromString(const DKString& filestring, const DKString& setting) {
	//DKDEBUGFUNC(filestring, setting);
	if(has(setting,"[") && has(setting,"]")){
		std::string::size_type temp = filestring.find(setting,0);
#ifndef ANDROID
        if(temp == std::string::npos){return DKStringArray(0);}
#else
		if(temp == std::string::npos){
			DKStringArray temp;
			return temp;
		}
#endif
		std::string::size_type start = filestring.find("]",temp);
		std::string::size_type end = filestring.find("[",start);
		if(end == std::string::npos){end = filestring.size();}

		DKString out = filestring.substr(start+1, end-start-1);
		//ok now each one into array
		DKStringArray outs;
		int begin = 1;

		while(1){
			int end = out.find("\n",begin);
			if(end==std::string::npos){return outs;}
			DKString string = out.substr(begin, end-begin);
			replace(string,"\r","");
			replace(string,"\n"," ");
			trim(string);
			if(!same(string,"")){
				outs.push_back(string);
			}
			begin=end+1;
		}
	}
#ifndef ANDROID
        return DKStringArray(0);
#else
		DKStringArray temp;
		return temp;
#endif
}
*/

DKString pointerToAddress(const void* pointer) {
	//DKDEBUGFUNC(event);  //EXCESSIVE LOGGING
	//DKASSERT(pointer);

	std::stringstream ss;
	const void* address = static_cast<const void*>(pointer);
#if WIN
	ss << "0x" << address;
#else 
	ss << address;
#endif
	if (same("0xDDDDDDDD", ss.str())) {
		DKERROR("ss = 0xDDDDDDDD\n");
		return "";
	}
	return ss.str();
}

void* addressToPointer(const DKString& address) {
	//DKDEBUGFUNC(address);  //EXCESSIVE LOGGING
	DKASSERT(!address.empty());

	void* pointer;
	if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos) {
		DKERROR("address:" + address + " is not a valid hex notation! \n");
		return NULL;
	}
	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address.substr(2, address.size() - 2);
	std::uint64_t tmp;
	if (!(ss >> std::hex >> tmp)) {
		DKERROR("address invalid! \n");
		return NULL;
	}
	pointer = reinterpret_cast<void*>(tmp);
	DKASSERT(pointer);
	
	return pointer;
}