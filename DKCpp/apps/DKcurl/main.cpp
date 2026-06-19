/*
* This source file is part of DigitalKnob, the cross-platform C/C++/Javascript/Html/Css Solution
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


//#define CURL_STATICLIB
#include <curl/curl.h>

CURL* curl;

bool CurlInit(){
	if(curl)
		curl_easy_cleanup(curl);
	CURLcode curlcode = curl_global_init(CURL_GLOBAL_ALL); 
	if(curlcode != CURLE_OK){
		printf("curl invalid %s\n", curl_easy_strerror(curlcode));
		return 1;
	}
	curl = curl_easy_init(); //NOTE: Curl inits are NOT thread safe.
	if(!curl){
		printf("curl invalid\n");
		return 1;
	}
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
	return true;
}

int main(int argc, char** argv){

	CurlInit();
    return 0;
}
