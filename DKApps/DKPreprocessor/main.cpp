/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include <iostream>
#include <stdio.h>
#include "DKPreprocessor.h"

int main() {
	DKPreprocessor::PrintPreprocessor();
	printf("DKDATE      = %s \n", DKDATE);
	printf("DKTIME      = %s \n", DKTIME);
	printf("OS          = %s \n", DKOS);
	//printf("OS Version  = %s \n", DKOS_VERSION);
	printf("Processor   = %s \n", DKARCH);
	//printf("Bits        = %s \n", DKBITS);
	//printf("Compiler    = %s %s \n", DKCOMPILER, DKCOMPILER_VERSION);
	printf("C Version   = %s \n", DKC_LANGUAGE_VERSION);
	printf("C++ Version = %s \n", DKCPP_LANGUAGE_VERSION);
	printf("Build type  = %s \n", DKBUILD_TYPE);
	
	printf("Hello World! from printf\n");
    std::cout << "Hello World! from std::cout" << std::endl;
	std::cout << "(press enter to exit)" << std::endl;
	std::cin.get(); //wait for enter to exit
    return 0;
}