#include <iostream>
#include <cstring>
#include <type_traits>
#include <inttypes.h>
#include <string>
#include <sstream>
#include <iomanip>

template< typename T > const std::uintptr_t objectToAddress(T& obj) {
	std::cout << "objectToAddress(" << obj << ")" << std::endl;
	const void* v_ptr = (const void*)&obj;
	return (std::uintptr_t)v_ptr;
}

template< typename T > void addressToObject(const std::uintptr_t& address, T& obj) {
	std::cout << "addressToPointer(" << address << ")" << std::endl;
	const void* v_ptr = (const void*)address;
	obj = *(T*)v_ptr;
}

template< typename T > T addressToObjectB(const std::uintptr_t& address) {
	std::cout << "addressToPointer(" << address << ")" << std::endl;
	const void* v_ptr = (const void*)address;
	return *(T*)v_ptr;
}

int main() {
	
	//////// Object -> Address -> Object /////////////////////////
	std::string myStringA = "String converted to address and back";
	
	// To address
	const std::uintptr_t addressA = objectToAddress(myStringA);
	std::cout << "addressA = " << addressA << std::endl;
	
	// Back to object
	std::string objA;
	addressToObject(addressA, objA);
	std::cout << "objA = " << objA << std::endl;
	
	std::string objB = addressToObjectB<std::string>(addressA);
	std::cout << "objB = " << objB << std::endl;
}