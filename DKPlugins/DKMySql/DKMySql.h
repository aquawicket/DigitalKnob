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

#pragma once
#ifndef DKMySql_H
#define DKMySql_H

WARNING_DISABLE
//#if defined (WIN32) || defined (WIN64)
  //#include <winsock.h>
  //#pragma warning (disable: 4514 4786)
  //#pragma warning( push, 3 )
//#endif

//#include <stdio.h>
//#include <string.h>

#if !defined (WIN32) && !defined (WIN64)
  #include <unistd.h>
#endif
WARNING_ENABLE

#include "DK/DK.h"

#ifdef USE_mysql
	WARNING_DISABLE
	#include "mysql.h"
	WARNING_ENABLE
#else
	#include "DKCurl/DKCurl.h"
#endif


class DKMySql : public DKObjectT<DKMySql> 
{
public:
	bool Init();
	bool End();

	bool Connect(const DKString& host, const DKString& name, const DKString& pass, const DKString& port);
	bool Database(const DKString& database);
	bool Query(DKString query, DKStringArray& results);

#ifdef USE_mysql
	MYSQL mysql;
#endif 

};


REGISTER_OBJECT(DKMySql, true);

#endif //DKMySql_H