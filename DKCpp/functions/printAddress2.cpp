#include <iostream>
#include <cstring>
#include <type_traits>
#include <inttypes.h>
#include <string>
#include <sstream>
#include <iomanip>

template< typename T >
void addressToObject(const std::uintptr_t& address, T& obj)
{	
	std::cout << "addressToPointer(" << address << ")" << std::endl;
	const void* v_ptr = (const void*)address;
	obj = *(T*)v_ptr;
}


const std::uintptr_t pointerToAddress(const void* pointer) {
	std::cout << "pointerToAddress(" << (std::uintptr_t)pointer << ")" << std::endl;
	return (std::uintptr_t)pointer;
}

const void* addressToPointer(const std::uintptr_t& address) {
	std::cout << "addressToPointer(" << address << ")" << std::endl;
	return (const void*)address;
}

int main() 
{ 
	std::string str_var = "simple string";
	std::cout << "str_var = " << str_var << std::endl;

	const std::uintptr_t address = pointerToAddress(&str_var);
	std::cout << "address = " << address << std::endl;
	
	const void* v_ptr = addressToPointer(address);
	
	std::string test = *(std::string*)v_ptr;
	std::cout << "test = " << test << std::endl;
	
	std::string test2;
	addressToObject(address, test2);
	std::cout << "test = " << test2 << std::endl;
}