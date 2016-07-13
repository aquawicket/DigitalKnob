#pragma once
#ifndef DKMySql_H
#define DKMySql_H
#include "DK.h"

//#if defined (WIN32) || defined (WIN64)
  //#include <winsock.h>
  //#pragma warning (disable: 4514 4786)
  //#pragma warning( push, 3 )
//#endif

//#include <stdio.h>
//#include <string.h>

#ifdef USE_mysql
	#include "mysql.h"
#else
	#include "DKCurl.h"
#endif

#if !defined (WIN32) && !defined (WIN64)
  #include <unistd.h>
#endif

/////////////////////////////////////////
class DKMySql : public DKObjectT<DKMySql> 
{
public:
	void Init();
	void End();

	bool Connect(const DKString& host, const DKString& name, const DKString& pass, const DKString& port);
	bool Database(const DKString& database);
	bool Query(DKString query, DKStringArray& results);

#ifdef USE_mysql
	MYSQL mysql;
#endif 

};


REGISTER_OBJECT(DKMySql, true);

#endif //DKMySql_H

