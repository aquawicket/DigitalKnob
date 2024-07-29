#include <iostream>
#include <stdio.h>

int main() {
	printf("Hello World! from printf\n");
    std::cout << "Hello World! from std::cout" << std::endl;
	std::cout << "(press enter to exit)" << std::endl;
	std::cin.get(); //wait for enter to exit
    return 0;
}
