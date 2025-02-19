#include <iostream>
#include <stdio.h>

//int main(int argc, char* argv[]) {
int main(int argc, char **argv) {
    std::cout << "Hello World! from std::cout" << std::endl;
	
	std::cout << "(press enter to exit)" << std::endl;
	std::cin.get(); //wait for enter to exit
    return 13;
}
