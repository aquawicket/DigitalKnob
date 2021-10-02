#include "DK/stdafx.h"
#include "DKString.h"
#include "DKLog.h"


bool same(const DKString& str, const DKString& str2){
	if(str.compare(str2) == 0)
		return true;
	return false;
}

bool samei(const DKString& str, const DKString& str2){
	DKString temp1 = str;
	std::transform(temp1.begin(), temp1.end(), temp1.begin(), ::tolower);
	DKString temp2 = str2;
	std::transform(temp2.begin(), temp2.end(), temp2.begin(), ::tolower);
	if(same(temp1, temp2))
		return true;
	return false;
}

bool has(const DKString& str, const DKString& str2){
	int found = str.find(str2);
	if(found!=std::string::npos)
		return true;
	return false;
}


DKString toString(const int& _int){
	DKASSERT("replace this with std::to_string()\n");
	DKString s;
	std::stringstream out;
	out << _int;
	s = out.str();
	return s;
}

DKString toString(const unsigned int& _uint){
	DKASSERT("replace this with std::to_string()\n");
	DKString s;
	std::stringstream out;
	out << _uint;
	s = out.str();
	return s;
}

DKString toString(const long& _long){
	DKASSERT("replace this with std::to_string()\n");
	DKString s;
	std::stringstream out;
	out << _long;
	s = out.str();
	return s;
}

DKString toString(const unsigned long int& _ulongint){
	DKASSERT("replace this with std::to_string()\n");
	DKString s;
	std::stringstream out;
	out << _ulongint;
	s = out.str();
	return s;
}

DKString toString(const unsigned long long int& _ulonglongint){
	DKASSERT("replace this with std::to_string()\n");
	DKString s;
	std::stringstream out;
	out << _ulonglongint;
	s = out.str();
	return s;
}

DKString toString(const float& _float){
	DKASSERT("replace this with std::to_string()\n");
	DKString s;
	std::stringstream out;
	out << _float;
	s = out.str();
	return s;
}

DKString toString(const double& _double){
	DKASSERT("replace this with std::to_string()\n");
	DKString s;
	std::stringstream out;
	out << _double;
	s = out.str();
	return s;
}

DKString toString(const char* _charptr){
	return _charptr; //FIXME: shouldn't this be DKString(_charptr)
}

DKString toString(const unsigned char* _uchar) {
	return reinterpret_cast<char const*>(_uchar);
}

DKString toString(void* _voidptr){
	DKString *p = static_cast<DKString*>(_voidptr);
	DKString string = *p;
	return string;
}

DKString toString(const bool _bool){
	if(_bool)
		return "true";
	return "false";
}

#ifdef WIN32
DKString toString(const HWND hwnd){
	std::stringstream ss;
	ss << "0x" << hwnd;
	return ss.str();
}
#endif

#ifdef WIN32
DKString toString(const std::wstring& _wstring){
	int len;
    int slength = (int)_wstring.length();
    len = WideCharToMultiByte(CP_ACP, 0, _wstring.c_str(), slength, 0, 0, 0, 0); 
    std::string s(len, '\0');
    WideCharToMultiByte(CP_ACP, 0, _wstring.c_str(), slength, &s[0], len, 0, 0); 
    return s;
}
#endif // WIN32 || WIN64

DKString toString(const DKStringArray& arry, const char* seperator){
	DKString string = "";
	for(unsigned int i=0; i<arry.size(); ++i){
		string += arry[i];
		if(i < arry.size()-1)
			string += seperator;
	}
	return string;
}

/*
bool ArrayToString(const DKStringArray& arry, DKString& str, const char* seperator){
	str = "";
	for(unsigned int i=0; i<arry.size(); ++i){
		str += arry[i];
		if(i < arry.size()-1)
			str += seperator;
	}
	return true;
}
*/

bool replace(DKString& str, const DKString& oldStr, const DKString& newStr){
	size_t pos = 0;
	while((pos = str.find(oldStr, pos)) != std::string::npos){
		str.replace(pos, oldStr.length(), newStr);
		pos += newStr.length();
	}
	return true;
}

bool replace_first(DKString& str, const DKString& oldStr, const DKString& newStr){
	size_t pos = 0;
	if((pos = str.find(oldStr, pos)) != std::string::npos){
		str.replace(pos, oldStr.length(), newStr);
		pos += newStr.length();
	}
	return true;
}

long toLong(const DKString& str){
#if defined(WIN32) || defined(MAC)
	return atol(str.c_str());
#endif 
    return DKERROR("toLong() not implemented for this OS \n");
}

unsigned long long int toULongLong(const DKString& str){
#if defined(WIN32) || defined(MAC)
	return strtoull(str.c_str(), NULL, 0);
#endif 
    return DKERROR("toULongLong() not implemented for this OS \n");
}

int toInt(const DKString& str){
	return  atoi(str.c_str());
}

bool toBool(const DKString& str){
    if(str.empty())
		return false;
	if(str == "false")
		return false;
	if(str == "0")
		return false;
	return true;
}

unsigned int toUInt(const DKString& str){
	return atoi(str.c_str());
}

float toFloat(const DKString& str){
	return (float)atof(str.c_str());
}

bool IsNumber(const DKString& str){
    std::string::const_iterator it = str.begin();
    while (it != str.end() && std::isdigit(*it)) ++it;
    return !str.empty() && it == str.end();
}

#ifdef WIN32
HWND toHWND(const DKString& str){
	DKString hex = str;
	hex.erase(0,2);
	unsigned int x;   
	std::stringstream ss;
	ss << std::hex << hex;
	ss >> x;
	return (HWND)x;
}
#endif

bool Pad(int num, char character, DKString& str){
	std::ostringstream ss;
	ss << std::setw(num) << std::setfill(character) << str;
	str = ss.str();
	return true;
}

bool RemoveDuplicates(DKStringArray& arry){
	sort( arry.begin(), arry.end() );
	arry.erase( unique( arry.begin(), arry.end() ), arry.end() );
	return true;
}

bool getSettingFromString(const DKString& filestring, const DKString& setting, DKString& value){
	//If the variable looks like this: [VARIABLE]
	//then we return everything up to the next [VARIABLE] or to the end of the file.
	if(has(setting,"[") && has(setting,"]")){
		size_t temp = filestring.find(setting,0);
        if(temp == std::string::npos){return false;}
		size_t start = filestring.find("]",temp);
		size_t end = filestring.find("[",start);
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
	size_t temp = filestring.find(string,0);
    if(temp == std::string::npos){return false;}
	size_t start = filestring.find(" ",temp);
	size_t end = filestring.find("\n",start);
	DKString out = filestring.substr(start+1, end-start-1);
	replace(out,"\r","");
	replace(out,"\n","");
	trim(out);
	value = out;
	return true;
}

/*
////////////////////////////////////////////////////////////////////////////////////////
DKStringArray getSettingsFromString(const DKString& filestring, const DKString& setting)
{
	if(has(setting,"[") && has(setting,"]")){
		size_t temp = filestring.find(setting,0);
#ifndef ANDROID
        if(temp == std::string::npos){return DKStringArray(0);}
#else
		if(temp == std::string::npos){
			DKStringArray temp;
			return temp;
		}
#endif
		size_t start = filestring.find("]",temp);
		size_t end = filestring.find("[",start);
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

DKString& rtrim(DKString& s, const char* t) {
	return s.erase(s.find_last_not_of(t) + 1);
	//return s;
}

DKString& ltrim(DKString& s, const char* t) {
	return s.erase(0, s.find_first_not_of(t));
	//return s;
}

DKString& trim(DKString& s, const char* t) {
	return ltrim(rtrim(s, t), t);
}


bool toStringArray(DKStringArray& output, const DKString& str, const DKString& seperator){
	//FIXME - while(1) loops are dangerous 
	DKString text = str + seperator; //add a seperator at the end, or we won't get the last variable

	int begin = 0;
	//int end;
	while(1){
	//while(end != std::string::npos){
		int end = text.find(seperator, begin);
		if(end==std::string::npos){return true;}
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
}

DKString toLower(const DKString& input){
    DKString output = input;
    std::transform( output.begin(), output.end(), output.begin(), ::tolower );
    return output;
}

DKString toUpper(const DKString& input){
    DKString output = input;
    std::transform( output.begin(), output.end(), output.begin(), ::toupper );
    return output;
}

#ifdef WIN32
std::wstring toWString(const DKString& str){
	int len;
	int slength = (int)str.length() + 1;
	len = MultiByteToWideChar(CP_ACP, 0, str.c_str(), slength, 0, 0);
	wchar_t* buf = new wchar_t[len];
	MultiByteToWideChar(CP_ACP, 0, str.c_str(), slength, buf, len);
	std::wstring r(buf);
	delete[] buf;
	return r;
}
#endif
