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

#include "dk_preprocessor.h"


DKMESSAGE(test DKMESSAGE)
DKWARNING(test DKWARNING)
//DKERROR(test DKERROR)

WARNING_DISABLE
#include <stdio.h>
WARNING_ENABLE
#include "dk_echo.h"



int PrintPreprocessor(){
	dk_echo("dk_preprocessor::PrintPreprocessor()\n");

#ifdef RTTI_ENABLED
	dk_echo("RTTI_ENABLED = TRUE\n");
#else
	dk_echo("RTTI_ENABLED = FALSE\n");
#endif

#ifdef __has_builtin
	dk_echo("__has_builtin = TRUE\n");
#else
	dk_echo("__has_builtin = FALSE\n");
#endif

#ifdef __has_feature
	dk_echo("__has_feature = TRUE\n");
#else
	dk_echo("__has_feature = FALSE\n");
#endif

#ifdef __has_include
	dk_echo("__has_include = TRUE\n");
#else
	dk_echo("__has_include = FALSE\n");
#endif

	dk_echo("__STDC_VERSION__       = %s \n", __STDC_VERSION__);
	
	dk_echo("DKDATE                 = %s \n", DKDATE);
	dk_echo("DKTIME                 = %s \n", DKTIME);
	dk_echo("DKOS                   = %s \n", DKOS);
	dk_echo("DKOS_VERSION           = %s \n", DKOS_VERSION);
	dk_echo("DKARCH                 = %s \n", DKARCH);
	dk_echo("DKBITS                 = %d \n", DKBITS);
	dk_echo("DKCOMPILER             = %s \n", DKCOMPILER);
	dk_echo("DKCOMPILER_VERSION     = %s \n", DKCOMPILER_VERSION);
	dk_echo("DKC_LANGUAGE_VERSION   = %s \n", DKC_LANGUAGE_VERSION);
	dk_echo("DKCPP_LANGUAGE_VERSION = %s \n", DKCPP_LANGUAGE_VERSION);
	dk_echo("DKBUILD_TYPE           = %s \n", DKBUILD_TYPE);
	
	int exit_status - 0;
	return exit_status;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status = PrintPreprocessor();
	return exit_status;
}
#endif