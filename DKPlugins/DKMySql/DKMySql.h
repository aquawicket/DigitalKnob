#pragma once
#ifndef DKMySql_H
#define DKMySql_H

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

#include "DK/DK.h"

#ifdef USE_mysql
	#include "mysql.h"
#else
	#include "DKCurl/DKCurl.h"
#endif

/////////////////////////////////////////
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