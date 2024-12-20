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

#include "DKPreprocessor.h"


DKMESSAGE(test DKMESSAGE)
DKWARNING(test DKWARNING)
//DKERROR(test DKERROR)

WARNING_DISABLE
#include <stdio.h>
WARNING_ENABLE




int PrintPreprocessor(){
	printf("DKPreprocessor::PrintPreprocessor()\n");

#ifdef RTTI_ENABLED
	printf("RTTI_ENABLED = TRUE\n");
#else
	printf("RTTI_ENABLED = FALSE\n");
#endif

#ifdef __has_builtin
	printf("__has_builtin = TRUE\n");
#else
	printf("__has_builtin = FALSE\n");
#endif

#ifdef __has_feature
	printf("__has_feature = TRUE\n");
#else
	printf("__has_feature = FALSE\n");
#endif

#ifdef __has_include
	printf("__has_include = TRUE\n");
#else
	printf("__has_include = FALSE\n");
#endif

	printf("__STDC_VERSION__       = %s \n", __STDC_VERSION__);
	
	
	
	
	printf("DKDATE                 = %s \n", DKDATE);
	printf("DKTIME                 = %s \n", DKTIME);
	printf("DKOS                   = %s \n", DKOS);
	printf("DKOS_VERSION           = %s \n", DKOS_VERSION);
	printf("DKARCH                 = %s \n", DKARCH);
	printf("DKBITS                 = %d \n", DKBITS);
	printf("DKCOMPILER             = %s \n", DKCOMPILER);
	printf("DKCOMPILER_VERSION     = %s \n", DKCOMPILER_VERSION);
	printf("DKC_LANGUAGE_VERSION   = %s \n", DKC_LANGUAGE_VERSION);
	printf("DKCPP_LANGUAGE_VERSION = %s \n", DKCPP_LANGUAGE_VERSION);
	printf("DKBUILD_TYPE           = %s \n", DKBUILD_TYPE);
	return 0;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
int main() {
	PrintPreprocessor();
    return 0;
}
#endif