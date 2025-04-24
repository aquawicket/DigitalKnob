#include <iostream>
#include <stdio.h>

<<<<<<< HEAD
int main() {
    std::cout << "Hello World! from std::cout" << std::endl;
	
	//std::cout << "(press enter to exit)" << std::endl;
	//std::cin.get(); //wait for enter to exit
=======
//int main(int argc, char* argv[]){
int main(int argc, char** argv){
    std::cout << "Hello World! from std::cout" << std::endl;
	
	std::cout << "(press enter to exit)" << std::endl;
	std::cin.get(); //wait for enter to exit
>>>>>>> Development
    return 13;
}
