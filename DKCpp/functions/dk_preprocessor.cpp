/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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

#include "dk_preprocessor.hpp"

DKMESSAGE(test DKMESSAGE)
DKWARNING(test DKWARNING)
//DKERROR(test DKERROR)

WARNING_DISABLE
#include <stdio.h>
WARNING_ENABLE


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){

	#ifdef __has_builtin
		std::cout << "__has_builtin 		= ON\n";
	#endif
	#ifdef __has_feature
		std::cout << "__has_feature 		= ON\n";
	#endif
	#ifdef __has_include
		std::cout << "__has_include 		= ON\n";
	#endif
	#ifdef DESKTOP	
		std::cout << "DESKTOP            	" << DESKTOP << "\n";
	#endif
	#ifdef MOBILE	
		std::cout << "MOBILE            	" << MOBILE << "\n";
	#endif
	#ifdef __clang__	
		std::cout << "__clang__          	" << __clang__ << "\n";
	#endif
	#ifdef __GNUG__	
		std::cout << "__GNUG__           	" << __GNUG__ << "\n";
	#endif
	#ifdef __COSMOPOLITAN__	
		std::cout << "__COSMOPOLITAN__   	" << __COSMOPOLITAN__ << "\n";
	#endif 
	#ifdef __COSMOCC__	
		std::cout << "__COSMOCC__        	" << __COSMOCC__ << "\n";
	#endif
	#ifdef __llvm__	
		std::cout << "__llvm__           	" << __llvm__ << "\n";
	#endif
	#ifdef __MINGW64__	
		std::cout << "__MINGW64__        	" << __MINGW64__ << "\n";
	#endif
	#ifdef __MINGW32__	
		std::cout << "__MINGW32__        	" << __MINGW32__ << "\n";
	#endif
	#ifdef _MSC_VER	
		std::cout << "_MSC_VER           	" << _MSC_VER << "\n";
	#endif
	std::cout << "DKDATE                 	" << DKDATE << "\n";
	std::cout << "DKTIME                 	" << DKTIME << "\n";
	std::cout << "DKOS                   	" << DKOS << "\n";
	std::cout << "DKOS_VERSION           	" << DKOS_VERSION << "\n";
	std::cout << "DKARCH                 	" << DKARCH << "\n";
	std::cout << "DKBITS                 	" << DKBITS << "\n";
	std::cout << "DKCOMPILER             	" << DKCOMPILER << "\n";
	std::cout << "DKCOMPILER_VERSION     	" << DKCOMPILER_VERSION << "\n";
	std::cout << "DKC_LANGUAGE_VERSION   	" << DKC_LANGUAGE_VERSION << "\n";
	std::cout << "DKCPP_LANGUAGE_VERSION	" << DKCPP_LANGUAGE_VERSION << "\n";
	std::cout << "Target_Type           	" << Target_Type << "\n";

	return 0;
}
#endif