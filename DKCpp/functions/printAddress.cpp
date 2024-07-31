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
	uintptr_t u_ptr = 0;
	if(std::is_pointer<T>::value){
		u_ptr = (uintptr_t)obj;
	} else {
		u_ptr = (uintptr_t)&obj;
	}
	
	std::stringstream ss;
	ss << std::hex << u_ptr;
	std::string address = ss.str();
	if(address.compare(0, 2, "0x") != 0){
		address.insert(0, "0x");
	}
	std::cout << "address = " << std::hex << address << std::endl;
	printf("address = %s\n", address.c_str());
	return address;
}

//template< typename T >
int* from_hex(std::string& address)
{
	if(address.compare(0, 2, "0x") != 0){
		printf("ERROR: address does not start with 0x \n");
		return NULL;
	}
	int* obj = nullptr;
	std::stringstream ss;
	ss << address;
	std::uint64_t tmp;
	if (!(ss >> std::hex >> tmp)) {
		std::cout << address << ": invalid address" << std::endl;
		return NULL;
	}
	obj = reinterpret_cast<int*>(tmp);
	return obj;
}

int main() 
{ 
	int int_var = 10;
	std::cout << "int_var = " << int_var << std::endl;
	int *int_var_ptr = &int_var;
	std::cout << "*int_var_ptr = " << *int_var_ptr << std::endl;
	printf("%p \n", &int_var);
	printf("%s \n", to_hex(int_var).c_str());
	to_hex(&int_var);
    void* v_ptr = &int_var;
	to_hex(v_ptr);
	//uintptr_t u_ptr = a; //BAD
	//to_hex(u_ptr);    //BAD
	
	
	int* i_ptr = &int_var;
	std::string hex = to_hex(i_ptr);
	int *c = from_hex(hex);
	std::cout << "c = " << c << std::endl;
	std::cout << "*c = " << *c << std::endl;
	std::cout << "&c = " << &c << std::endl;
}