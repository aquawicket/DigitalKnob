#include <iostream>
#include <cstring>
#include <type_traits>
#include <inttypes.h>
#include <string>
#include <sstream>
#include <iomanip>

template< typename T >
void anyToAddress(const T &obj)
{	
	/*
	if(std::is_reference<T>::value){
		std::cout << "is reference " << std::endl;
	} else {
		std::cout << "not reference " << std::endl;
	}
	*/
	if(std::is_pointer<T>::value){
		std::cout << "is pointer " << std::endl;
		//std::cout << std::hex << (std::uintptr_t)obj << std::endl;
		//std::cout << std::hex << (std::uintptr_t)(void *)obj << std::endl;
	} else {
		std::cout << "not pointer " << std::endl;
		std::cout << std::hex << (std::uintptr_t)&obj << std::endl;
	}
	
}


std::string pointerToAddress(const void* pointer) 
{
	std::stringstream ss;
	ss << std::hex << (std::uintptr_t)pointer;
	std::string address = ss.str();
	std::cout << "address = " << address << std::endl;
	return address;
}

void* addressToPointer(const std::string& address) 
{
	void* pointer;
	//if (address.compare(0, 2, "0x") != 0){
	//	std::cout << "WARNING: address:" << address << " does not start with 0x \n";
	//}
	if (address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos) {
		std::cout << "address:" << address << " is not a valid hex notation! \n";
		return NULL;
	}
	std::stringstream ss;
	ss << address;
	//std::cout << "ss = " << ss.str() << std::endl;
	//ss << address.substr(2, address.size() - 2);
	std::uintptr_t tmp;
	if (!(ss >> std::hex >> tmp)) {
		std::cout << "address invalid! \n";
		return NULL;
	}
	std::cout << "tmp = " << std::hex << tmp << std::endl;
	pointer = reinterpret_cast<void*>(tmp);
	return pointer;
}

int main() 
{ 
	std::string str_var = "simple string";
	std::cout << "str_var = " << str_var << std::endl;
	anyToAddress(str_var);
	anyToAddress(&str_var);
	//anyToAddress(*str_var);
	
	std::string* str_var_ptr = &str_var;
	std::cout << "*str_var_ptr = " << *str_var_ptr << std::endl;
	anyToAddress(str_var_ptr);
	anyToAddress(&str_var_ptr);
	
	std::string address = pointerToAddress(str_var_ptr);
	std::cout << "address = " << address << std::endl;
	
	void* v_ptr = addressToPointer(address);
	std::string test = *(std::string*)v_ptr;
	std::cout << "test = " << test << std::endl;

}