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

#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DK/DKString.h"
#include "DKAssets/DKAssets.h"
#include "DKMySql/DKMySql.h"


bool DKMySql::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKMySqlJS");
	DKClass::DKCreate("DKMySqlV8");
	
	DKClass::DKCreate("DKCurl");
#ifdef USE_mysql
	if(mysql_init(&mysql)==NULL){
		DKERROR("Failed to initate MySQL connection\n");
		return false;
	}
#endif
	return true;
}

bool DKMySql::End(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKMySqlJS");
	DKClass::DKCreate("DKMySqlV8");
	
#ifdef USE_mysql
	mysql_close(&mysql);
#endif
	return true;
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKMySql::Connect(const DKString& host, const DKString& name, const DKString& pass, const DKString& port)
{
	DKDEBUGFUNC(host, name, pass, port);
#ifdef USE_mysql
	if(!mysql_real_connect(&mysql,host.c_str(),name.c_str(),pass.c_str(),NULL,port,NULL,0)){ 
		DKERROR("Failed to connect to MySQL\n");
		return false;
	}
#else

	DKString response;
	DKString send = DKFile::online_assets+"/DKMySql/DKMySql.php?host=";
	send += host;
	if(!port.empty()){
		send += ":";
		send += port;
	}
	send += ",";
	send += name;
	send += ",";
	send += pass;

	DKCurl::Get("DKCurl0")->HttpToString(send,response);
	if(response.empty()){
		DKINFO("Successfully connected to MySql server\n");
		return true;
	}	
#endif

	DKERROR("Could not connect to MySql server\n");
	return false;
}

////////////////////////////////////////////////
bool DKMySql::Database(const DKString& database)
{
	DKDEBUGFUNC(database);
#ifdef USE_mysql
	//Not setup
#else
	

	DKString response;
	DKString send = DKFile::online_assets+"/DKMySql/DKMySql.php?database=";
	send += database;

	DKCurl::Get("DKCurl0")->HttpToString(send,response);
	return true;
#endif
	return false;
}


///////////////////////////////////////////////////////////
bool DKMySql::Query(DKString query, DKStringArray& results)
{
	DKDEBUGFUNC(query, "DKStringArray&");
	results.clear();
#ifdef USE_mysql
	//if(mysql_real_query(&mysql,query.c_str(),strlen(query.c_str())) != 0){
	if(mysql_query(&mysql,query.c_str()) != 0){
		DKERROR( "\n Query failed: %s\n"/*,mysql_error(&mysql)*/);
		return false;
	}

    //http://anaturb.net/MySQL/mysql_c.htm
	MYSQL_RES *res;
	MYSQL_ROW  row;
    res = mysql_store_result(&mysql);
	while(row = mysql_fetch_row(res)){
		results.push_back(row[0]);
    }
#else

	DKINFO("Query: "+query+"\n");
	
	DKString response;
	DKString send = DKFile::online_assets+"/DKMySql/DKMySql.php?Query=";
	send += query;

	DKCurl::Get("DKCurl0")->HttpToString(send,response);

	if(has(response, "DKERROR")){
		DKERROR(response+"\n");
		return false;
	}

	//split up the csv into a DKStringArray
	std::istringstream ss(response);
	std::string string;
	while(std::getline(ss, string, ',')){
		results.push_back(string);
	}

	DKINFO("\n Query succeeded\n");
	DKINFO("-> "+response+"+\n");
	return true;
#endif

	return false;
}