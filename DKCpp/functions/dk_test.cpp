#include "dk_test.h"
#include <iostream>
#include <stdio.h>

void dk_test() {
	printf("dk_test()\n");
}

int main() {
	dk_test();
	
	std::cout << "(press enter to exit)" << std::endl;
	std::cin.get(); //wait for enter to exit
    return 0;
}
