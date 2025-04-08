//#include "dk_objAddress.hpp"
#include <sstream>
#include <string>
#include <iostream>
#include <type_traits>

//################################################################################
//# same(str, str2)
//#
bool same(const std::string& str, const std::string& str2){
	//DKDEBUGFUNC(str, str2);
	if(str.compare(str2) == 0)
		return true;
	return false;
}

//################################################################################
//# as_pointer_to(address)
//#
//# assumes that the address stored in the string is valid and is in hex
//# assumes that T is an (optionally cv-qualified) object type or void
template < typename T = const void > T* as_pointer_to( const std::string& address )
{
    static_assert( std::is_object<T>::value || std::is_void<T>::value, "invalid type" ) ;

    // http://en.cppreference.com/w/cpp/string/basic_string/stoul
    const unsigned long long value = std::stoull( address, nullptr, 16 ) ; // may throw
    return reinterpret_cast< const T* >(value) ;
}


void* addressToObject(const std::string& address){
	//DKDEBUGFUNC(address);  //EXCESSIVE LOGGING
	
	//FIXME:  Error example (win_x86_64_mingw64_gcc)
	//		0x0x23aefc8: the address is not a valid hex notation
	//
	void* object = nullptr;
	if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0x123456789abcdefABCDEF", 2) != std::string::npos){
		
		std::cout << (address+": the address is not a valid hex notation\n");
		
		//print which of the evaluators failed.
		if(address.compare(0, 2, "0x") != 0)
			printf("address.compare(0, 2, \"0x\") != 0 \n");
		if(address.size() <= 2)
			printf("(address.size() <= 2 \n");
		if(address.find_first_not_of("0x123456789abcdefABCDEF", 2) != std::string::npos)
			printf("address.find_first_not_of(\"0x123456789abcdefABCDEF\", 2) != std::string::npos");
		return NULL;
	}
	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address.substr(2, address.size() - 2);
	std::uint64_t tmp;
	if (!(ss >> std::hex >> tmp)){
		std::cout << (address + ": invalid address\n");
		return NULL;
	}
	object = reinterpret_cast<void*>(tmp);
	
	if (!object){
		printf("invalid object\n");
		return NULL;
	}
//	if (object->GetTagName().empty())
//		return NULL;
	return object;
}

//################################################################################
//# objectToAddress(element)
//#
std::string objectToAddress(void* object){
	//DKDEBUGFUNC(element);  //EXCESSIVE LOGGING
	if (!object){
		std::cout << ("invalid object\n");
		return "";
	}
	std::stringstream ss;
	const void* ptr = static_cast<const void*>(object);
	ss << ptr;
	std::string address = ss.str();
	//if(address.compare(0, 2, "0x") != 0){
	//	address.insert(0, "0x");
	//}

	if (same("0xDDDDDDDD", address)){
		std::cout << ("address = 0xDDDDDDDD\n");
		return "";
	}
	return address;
}


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main(int argc, char** argv){
	const std::string str = "000000000018FB74" ;
    const void* pv = as_pointer_to<const void>(str) ;
    std::cout << pv << '\n' ;
    const int* pi = as_pointer_to<const int>(str) ; 
    std::cout << pi << '\n' ;
	
	
	std::string myString = "a test string to turn into an object";
	void* string_obj = &myString;
	std::string address = objectToAddress(string_obj);
	std::cout << ("address = "+address+"\n");
	void* string_objB = addressToObject(address);
	std::string myStringB = *(std::string*)string_objB;
    return 0;
}
#endif
