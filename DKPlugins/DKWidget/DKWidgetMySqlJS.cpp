#ifdef USE_DKMySql
#ifdef USE_DKRocket
#ifdef USE_DKDuktape 

#include "DKMySql/DKMySql.h"
#include "DKWidget/DKWidgetMySqlJS.h"

////////////////////////////
bool DKWidgetMySqlJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKWidgetMySql_DeleteRecord", DKWidgetMySqlJS::DeleteRecord);
	DKDuktape::AttachFunction("DKWidgetMySql_GetFirstRecordNum", DKWidgetMySqlJS::GetFirstRecordNum);
	DKDuktape::AttachFunction("DKWidgetMySql_GetLastRecordNum", DKWidgetMySqlJS::GetLastRecordNum);
	DKDuktape::AttachFunction("DKWidgetMySql_GetNextRecordNum", DKWidgetMySqlJS::GetNextRecordNum);
	DKDuktape::AttachFunction("DKWidgetMySql_GetPrevRecordNum", DKWidgetMySqlJS::GetPrevRecordNum);
	DKDuktape::AttachFunction("DKWidgetMySql_LoadRecord", DKWidgetMySqlJS::LoadRecord);
	DKDuktape::AttachFunction("DKWidgetMySql_Prep", DKWidgetMySqlJS::Prep);
	DKDuktape::AttachFunction("DKWidgetMySql_SaveRecord", DKWidgetMySqlJS::SaveRecord);
	DKDuktape::AttachFunction("DKWidgetMySql_Search", DKWidgetMySqlJS::Search);
	return true;
}

///////////////////////////////////////////
int DKWidgetMySqlJS::Prep(duk_context* ctx)
{
	DKDEBUGFUNC();
	DKString id = duk_require_string(ctx, 0);
	DKINFO("DKWidgetMySql_Prep "+ id +"\n");

	//This should look at all the the "sql" tags and make sure the database has the (Database, Table and Field)
	
	DKElementList elements;
	DKWidget::GetElements(id, elements);
	//DKLog("checking "+toString(elements.size())+" nodes...\n");
	
	for(unsigned int i=0; i<elements.size(); ++i){

		if( elements[i]->HasAttribute("sql") ){
			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);
			
			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");
			PrepField(arry[0], arry[1], arry[2]);
		}
	}
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
int DKWidgetMySqlJS::PrepField(const DKString& database, const DKString& table, const DKString& field)
{
	DKDEBUGFUNC(database, table, field);
	// CHECK DATABASE //
	/*
	DKString query = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '"+database+"'";

	DKStringArray records;
	DKMySql::Get()->Query(query, records);
	if(records.size() < 3){ 
		DKLog("Creating Database "+database+"\n");
		query = "CREATE DATABASE '"+database+"'"; //FIXME: NOT Working
		DKMySql::Get()->Query(query, records);
		//DKLog(result);
	}

	// CHECK TABLE //
	DKString query = "SHOW TABLES LIKE '"+table+"'";
	DKStringArray records;
	DKMySql::Get()->Query(query, records);

	if(records.size() < 3){
		DKLog("Creating Table "+table+"\n");
		query = "CREATE TABLE "+table+" (ID INT(10) NOT NULL AUTO_INCREMENT, PRIMARY KEY (ID))";
		DKMySql::Get()->Query(query, records);
		//DKLog(result);
	}
	
	// CHECK FIELD //
	var query = "SELECT "+field+" FROM "+table;
	var result = Query(query);
	var records = result.split(',');
	if(records.length < 3){
		DKLog("Creating Field "+field+"\n");
		var query = "ALTER TABLE "+table+" ADD "+field+" VARCHAR(60) NOT NULL";
		var result = Query(query);
		DKLog(result);
	}
	*/
	return 1;
}

////////////////////////////////////////////////////////
int DKWidgetMySqlJS::GetFirstRecordNum(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKElementList elements;
	DKWidget::GetElements(id, elements);

	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			DKString query = "SELECT ID FROM "+arry[1]+" ORDER BY ID ASC LIMIT 1";
			DKStringArray records;
			DKMySql::Get("DKMySql")->Query(query, records);

			if(records.size() > 1){
				duk_push_string(ctx, records[1].c_str());
				return 1; //return on the first thing we find
			}
		}
	}

	return 0;
}

///////////////////////////////////////////////////////
int DKWidgetMySqlJS::GetLastRecordNum(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKElementList elements;
	DKWidget::GetElements(id, elements);

	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			DKString query = "SELECT ID FROM "+arry[1]+" ORDER BY ID DESC LIMIT 1";
			DKStringArray records;
			DKMySql::Get("DKMySql")->Query(query, records);

			if(records.size() > 1){
				duk_push_string(ctx, records[1].c_str());
				return 1; //return on the first thing we find
			}
		}
	}

	return 0;
}

///////////////////////////////////////////////////////
int DKWidgetMySqlJS::GetPrevRecordNum(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKString recordNum = duk_require_string(ctx, 1);
	DKElementList elements;
	DKWidget::GetElements(id, elements);

	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			DKString query = "SELECT ID FROM "+arry[1]+" WHERE ID = (SELECT min(ID) FROM "+arry[1]+" WHERE ID < "+recordNum+")";
			DKStringArray records;
			DKMySql::Get("DKMySql")->Query(query, records);

			if(records.size() > 1){
				duk_push_string(ctx, records[1].c_str());
				return 1; //return on the first thing we find
			}
		}
	}

	return 0;
}

///////////////////////////////////////////////////////
int DKWidgetMySqlJS::GetNextRecordNum(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKString recordNum = duk_require_string(ctx, 1);
	DKElementList elements;
	DKWidget::GetElements(id, elements);

	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			DKString query = "SELECT ID FROM "+arry[1]+" WHERE ID = (SELECT min(ID) FROM "+arry[1]+" WHERE ID > "+recordNum+")";
			DKStringArray records;
			DKMySql::Get("DKMySql")->Query(query, records);

			if(records.size() > 1){
				duk_push_string(ctx, records[1].c_str());
				return 1; //return on the first thing we find
			}
		}
	}
	return 0;
}

/////////////////////////////////////////////////
int DKWidgetMySqlJS::LoadRecord(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKString recordNum = duk_require_string(ctx, 1);
	DKElementList elements;
	DKWidget::GetElements(id, elements);
	DKStringArray fields;
	DKString table;
	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			table = arry[1];
			fields.push_back(arry[2]);
		}
	}

	DKString query = "SELECT ";
	for(unsigned int i=0; i<fields.size(); ++i){
		query += fields[i];
		if(i < (fields.size()-1)){
			query += ", ";
		}
	}
	query += " FROM "+table+" WHERE ID="+recordNum;
	DKStringArray records;
	DKMySql::Get("DKMySql")->Query(query, records);


	int r = 1;
	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){
			
			DKWidget::SetValue(elements[i], records[r]);
			++r;
		}
	}
	return 1;
}

/////////////////////////////////////////////////
int DKWidgetMySqlJS::SaveRecord(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKString recordNum = duk_require_string(ctx, 1);
	DKElementList elements;
	DKWidget::GetElements(id, elements);

	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			DKString query = "SELECT "+arry[2]+" FROM "+arry[1]+" WHERE ID="+recordNum;
			DKStringArray records;
			DKMySql::Get("DKMySql")->Query(query, records);

			if(records.size() > 1){
				DKString value = DKWidget::GetValue(elements[i]);
				if(!same(value, records[1]) && !same(arry[2], "ID")){
					DKINFO("Update Record. value="+value+" record="+records[1]+" \n");
					query = "UPDATE "+arry[1]+" SET "+arry[2]+"='"+value+"' WHERE ID="+recordNum;
					DKMySql::Get("DKMySql")->Query(query, records);
					//DKLog(result);
				}
			}
		}
	}
	return 1;
}

///////////////////////////////////////////////////
int DKWidgetMySqlJS::DeleteRecord(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKString recordNum = duk_require_string(ctx, 1);
	DKElementList elements;
	DKWidget::GetElements(id, elements);

	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			DKString query = "DELETE FROM "+arry[1]+" WHERE ID="+recordNum;
			DKStringArray records;
			DKMySql::Get("DKMySql")->Query(query, records);
			return 1;
		}
	}

	return 0;
}

/////////////////////////////////////////////
int DKWidgetMySqlJS::Search(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	DKString string = duk_require_string(ctx, 1);
	DKElementList elements;
	DKWidget::GetElements(id, elements);

	for(unsigned int i=0; i<elements.size(); ++i){
		if( elements[i]->HasAttribute("sql") ){

			DKINFO(elements[i]->GetId().CString());
			DKString sql;
			DKWidget::GetAttribute(elements[i], "sql", sql);
			DKINFO(sql);

			DKString id = elements[i]->GetId().CString();
			DKStringArray arry;
			toStringArray(arry, sql, ",");

			DKString query = "SELECT ID FROM "+arry[1]+" WHERE "+arry[2]+" LIKE '"+string+"'";
			DKStringArray records;
			DKMySql::Get("DKMySql")->Query(query, records);
			if(records.size() > 1){
				duk_push_string(ctx, records[1].c_str());
				return 1;
			}
		}
	}

	return 0;
}


#endif //USE_DKDuktape
#endif //USE_DKRocket
#endif //USE_DKMySql