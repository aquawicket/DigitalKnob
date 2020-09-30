//BROWSER

////////////////////////////////////////////////
function DKMySql_Connect(host, name, pass, port)
{
	var send = online_assets+"/DKMySql/DKMySql.php?host=";
	send += host;
	if(port){
		send += ":";
		send += port;
	}
	send += ",";
	send += name;
	send += ",";
	send += pass;
	var response = ajaxGetUrl(send);
	console.log(response+"\n");
	
	//FIXME
	//if(response.indexOf("console.error") != -1){
	//	return false;
	//}
	
	return true;
}

///////////////////////////////
function DKMySql_Database(name)
{
	var send = online_assets+"/DKMySql/DKMySql.php?database=";
	send += name;
	return ajaxGetUrl(send);
}

/////////////////////////////
function DKMySql_Query(query)
{
	var send = online_assets+"/DKMySql/DKMySql.php?Query=";
	send += query;
	return ajaxGetUrl(send);
}

/////////////////////////
function DKMySql_Prep(id)
{
	//This should look at all the the "sql" tags and make sure the database has the (Database, Table and Field)
	
	var nodes = document.getElementById(id).getElementsByTagName("*");
	console.log("checking "+nodes.length+" nodes...\n");
	
	for(var i=0; i<nodes.length; i++){
	
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			console.log(nodes[i].id+"\n");
			console.log(nodes[i].getAttribute("sql")+"\n");
			
			var id = nodes[i].id;
			var sql = nodes[i].getAttribute("sql").split(",");
			DKMySqlPrepField(sql[0], sql[1]);
		}
	}	
}

////////////////////////////////////////
function DKMySql_PrepField(table, field)
{
	//TODO: put this somewhere else, gui elements will work with the current active database
	// CHECK DATABASE //
	/*
	var query = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '"+database+"'";
	var result = DKMySqlQuery(query);
	console.log(result+"\n");
	var records = result.split(',');

	if(records.length < 3){
		console.log("Creating Database "+database+"\n");
		var query = "CREATE DATABASE '"+database+"'"; //FIXME: NOT Working
		var result = DKMySqlQuery(query);
		console.log(result+"\n");
	}
	*/
	
	// CHECK TABLE //
	var query = "SHOW TABLES LIKE '"+table+"'";
	var result = DKMySqlQuery(query);
	var records = result.split(',');
	if(records.length < 3){
		console.log("Creating Table "+table+"\n");
		var query = "CREATE TABLE "+table+" (ID INT(10) NOT NULL AUTO_INCREMENT, PRIMARY KEY (ID))";
		var result = DKMySql_Query(query);
		console.log(result+"\n");
	}
	
	// CHECK FIELD //
	var query = "SELECT "+field+" FROM "+table;
	var result = DKMySql_Query(query);
	var records = result.split(',');
	if(records.length < 3){
		console.log("Creating Field "+field+"\n");
		var query = "ALTER TABLE "+table+" ADD "+field+" VARCHAR(60) NOT NULL";
		var result = DKMySql_Query(query);
		console.log(result+"\n");
	}
}

//////////////////////////////////////
function DKMySql_GetFirstRecordNum(id)
{
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			
			var query = "SELECT ID FROM "+sql[0]+" ORDER BY ID ASC LIMIT 1";
			var result = DKMySql_Query(query);
			console.log(result+"\n");
			var records = result.split(',');
			if(records.length > 1){
				return records[1];
			}
			
		}
	}
}

/////////////////////////////////////
function DKMySql_GetLastRecordNum(id)
{
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			
			var query = "SELECT ID FROM "+sql[0]+" ORDER BY ID DESC LIMIT 1";
			var result = DKMySql_Query(query);
			console.log(result+"\n");
			var records = result.split(',');
			if(records.length > 1){
				return records[1];
			}
			
		}
	}
}

////////////////////////////////////////////////
function DKMySql_GetPrevRecordNum(id, recordNum)
{
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			
			var query = "SELECT ID FROM "+sql[0]+" WHERE ID = (SELECT min(ID) FROM "+sql[0]+" WHERE ID < "+recordNum+")";
			var result = DKMySql_Query(query);
			console.log(result+"\n");
			var records = result.split(',');
			if(records.length > 2){
				return records[1];
			}
			
		}
	}
	
	return 0;
}

////////////////////////////////////////////////
function DKMySql_GetNextRecordNum(id, recordNum)
{
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			
			var query = "SELECT ID FROM "+sql[0]+" WHERE ID = (SELECT min(ID) FROM "+sql[0]+" WHERE ID > "+recordNum+")";
			var result = DKMySql_Query(query);
			console.log(result+"\n");
			var records = result.split(',');
			if(records.length > 2){
					return records[1];
			}
			
		}
	}
	
	return 0;
}

//////////////////////////////////////////
function DKMySql_LoadRecord(id, recordNum)
{
	if(!recordNum){ return; }
	var table;
	var fields = [];
	//load the first record into the gui
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			
			table = sql[0];
			fields.push(sql[1]);
		}
	}
		
	var query = "SELECT ";
	for(var i=0; i<fields.length; ++i){
		query += fields[i];
		if(i < (fields.length-1)){
			query += ", ";
		}
	}
		
	query += " FROM "+table+" WHERE ID="+recordNum;
	var result = DKMySql_Query(query);
	console.log(result+"\n");
	var records = result.split(",");
		
	var r = 1;
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
	
			SetValue(nodes[i], records[r]);
			++r;
		}
	}
}

//////////////////////////////////////////
function DKMySql_SaveRecord(id, recordNum)
{
	//save any unmatching record fields
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			
			var query = "SELECT "+sql[1]+" FROM "+sql[0]+" WHERE ID="+recordNum;
			var result = DKMySql_Query(query);
			console.log(result+"\n");
			var records = result.split(',');
			if(records.length > 1){
				var value = GetValue(nodes[i]);
				if(value != records[1] && sql[1] != "ID"){
					console.log("Update Record. value="+value+" record="+records[1]+"\n");
					var query = "UPDATE "+sql[0]+" SET "+sql[1]+"='"+value+"' WHERE ID="+recordNum;
					var result = DKMySql_Query(query);
					console.log(result+"\n");
				}
			}
			
		}
	}
}

////////////////////////////////////////////
function DKMySql_DeleteRecord(id, recordNum)
{
	//save any unmatching record fields
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			var query = "DELETE FROM "+sql[0]+" WHERE ID="+recordNum;
			var result = DKMySql_Query(query);
			console.log(result+"\n");	
			return;
		}
	}
}

///////////////////////////////////
function DKMySql_Search(id, string)
{
	//save any unmatching record fields
	//var nodes = document.getElementById(id).childNodes;
	var nodes = document.getElementById(id).getElementsByTagName("*");
	for(var i=0; i<nodes.length; i++){
		if( nodes[i].nodeType === 1 && nodes[i].hasAttribute("sql") ){
			var sql = nodes[i].getAttribute("sql").split(",");
			
			var query = "SELECT ID FROM "+sql[0]+" WHERE "+sql[1]+" LIKE '"+string+"'";
			var result = DKMySql_Query(query);
			console.log(result+"\n");
			var records = result.split(',');
			if(records.length > 2){
				return records[1];
			}
		}
	}
}