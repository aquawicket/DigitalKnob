#include <iostream>
#include <cstring>
#include <type_traits>
#include <inttypes.h>

#include <string>
#include <sstream>
#include <iomanip>

template< typename T >
std::string to_hex(const T &obj)
{
	std::string address = "UNDEFINED";
	//if(std::is_pointer<T>::value){
		//u_ptr = (uintptr_t)obj;
		const void* ptr = static_cast<const void*>(&obj);
		//const uintptr_t ptr = static_cast<const uintptr_t>(&obj);
		std::cout << ptr << std::endl;
		std::stringstream ss;
		ss << std::hex << ptr;
		address = ss.str();
	//} else {
		//const void* ptr = static_cast<const void*>(obj);
		//u_ptr = (uintptr_t)&obj;
		//v_ptr = static_cast<void*>(&obj);
	//}
	
	/*
	std::stringstream ss;
	ss << std::hex << u_ptr;
	std::string address = ss.str();
	*/
	
	//if(address.compare(0, 2, "0x") != 0){
	//	address.insert(0, "0x");
	//}
	std::cout << "address = " << std::hex << address << std::endl;
	printf("address = %s\n", address.c_str());
	return address;
}

//template< typename T >
std::string* from_hex(std::string& address)
{
	//if(address.compare(0, 2, "0x") != 0){
	//	printf("ERROR: address does not start with 0x \n");
//		return NULL;
//	}
	std::string* obj = nullptr;
	std::stringstream ss;
	ss << address;
	std::intptr_t tmp;
	if (!(ss >> std::hex >> tmp)) {
		std::cout << address << ": invalid address" << std::endl;
		return NULL;
	}
	obj = reinterpret_cast<std::string*>(tmp);
	return obj;
}

int main(int argc, char **argv) {
{ 
	std::string str_var = "simple string";
	std::cout << "str_var = " << str_var << std::endl;
	std::string* str_var_ptr = &str_var;
	std::cout << "*str_var_ptr = " << *str_var_ptr << std::endl;
	printf("%p \n", &str_var);
	printf("%s \n", to_hex(str_var).c_str());
	to_hex(&str_var);
    void* v_ptr = &str_var;
	to_hex(v_ptr);
	//uintptr_t u_ptr = a; //BAD
	//to_hex(u_ptr);    //BAD
	
	

	std::string hex = to_hex(str_var_ptr);
	std::string* c = from_hex(hex);
	std::cout << "c = " << c << std::endl;
	std::cout << "*c = " << *c << std::endl;
	std::cout << "&c = " << &c << std::endl;
}