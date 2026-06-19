// shebang

#include <iostream>
#include <string>

int main(){
	std::string myVar = "value";
	std::cout << "myVar = '" << myVar << "'";					// w/ newline
	//std::cout << "myVar = '" << myVar << "'" << std::endl;	// no newline
	return 0;
}