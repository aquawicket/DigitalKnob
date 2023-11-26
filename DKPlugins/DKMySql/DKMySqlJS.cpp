/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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

#ifdef HAVE_DKDuktape
#include "DKMySql/DKMySql.h"
#include "DKMySql/DKMySqlJS.h"


bool DKMySqlJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKMySql_Connect", DKMySqlJS::Connect);
	DKDuktape::AttachFunction("CPP_DKMySql_Database", DKMySqlJS::Database);
	DKDuktape::AttachFunction("CPP_DKMySql_Query", DKMySqlJS::Query);
	return true;
}

int DKMySqlJS::Connect(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString host = duk_require_string(ctx, 0);
	DKString name = duk_require_string(ctx, 1);
	DKString pass = duk_require_string(ctx, 2);
	DKString port = duk_require_string(ctx, 3);
	DKMySql::Instance("DKMySql")->Connect(host, name, pass, port);
	return 1;
}

int DKMySqlJS::Database(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	DKMySql::Instance("DKMySql")->Database(name);
	return 1;
}

int DKMySqlJS::Query(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString query = duk_require_string(ctx, 0);
	DKStringArray records;
	DKMySql::Instance("DKMySql")->Query(query, records);
	if(records.empty()){ return 0; }
	DKString string = toString(records, ",");
	duk_push_string(ctx, string.c_str());
	return 1;
}

#endif //HAVE_DKDuktape
