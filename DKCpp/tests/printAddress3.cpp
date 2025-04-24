#include <iostream>
#include <cstring>
#include <type_traits>
#include <inttypes.h>
#include <string>
#include <sstream>
#include <iomanip>

//https://cplusplus.com/forum/general/266107/
/*
template <typename T>
std::string save_pointer(T *p){
    return std::to_string((uintptr_t)p);
}

template <typename T>
T *restore_pointer(const std::string &s){
    std::stringstream stream(s);
    uintptr_t ret;
    stream >> ret;
    return (T *)ret;
}
*/

<<<<<<< HEAD
template< typename T > const std::uintptr_t objectToAddress(T& obj) {
=======
template< typename T > const std::uintptr_t objectToAddress(T& obj){
>>>>>>> Development
	std::cout << "objectToAddress(" << obj << ")" << std::endl;
	const void* v_ptr = (const void*)&obj;
	return (std::uintptr_t)v_ptr;
}

<<<<<<< HEAD
template< typename T > T addressToObjectB(const std::uintptr_t& address) {
=======
template< typename T > T addressToObjectB(const std::uintptr_t& address){
>>>>>>> Development
	std::cout << "addressToPointer(" << address << ")" << std::endl;
	const void* v_ptr = (const void*)address;
	return *(T*)v_ptr;
}

<<<<<<< HEAD
int main() {
=======
int main(int argc, char** argv){
>>>>>>> Development
	
	//////// Object -> Address -> Object /////////////////////////
	std::string myStringA = "String converted to address and back";
	
	// To address
	const std::uintptr_t addressA = objectToAddress(myStringA);
	std::cout << "addressA = " << addressA << std::endl;
	
	// Back to object
	std::string rtn_myStringA = addressToObjectB<std::string>(addressA);
	std::cout << "rtn_myStringA = " << rtn_myStringA << std::endl;
}
