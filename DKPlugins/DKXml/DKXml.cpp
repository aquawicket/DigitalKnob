#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKXml/DKXml.h"

//////////////////
bool DKXml::Init()
{
	DKLog("DKXml::Init()\n", DKDEBUG);
	return true;
}

/////////////////
bool DKXml::End()
{
	DKLog("DKXml::End()\n", DKDEBUG);
	return true;
}

//////////////////////////////////////////////
bool DKXml::LoadDocument(const DKString& file)
{
	DKLog("DKXml::LoadDocument("+file+")\n", DKDEBUG);
	
	DKString path = file;
	if(!DKFile::VerifyPath(path)){ return false; } 

	DKString filedata;
	DKFile::FileToString(path,filedata);

	pugi::xml_parse_result result = doc.load(filedata.c_str(), pugi::parse_cdata | pugi::parse_wconv_attribute | pugi::parse_eol);
	if(!result){
		DKString description = result.description();
		DKString offset = toString((int)result.offset);
		DKLog("DKXml::LoadDocument("+file+"): "+description+" @ character: "+offset+" \n", DKERROR);
		DKFile::StringToFile(filedata, DKFile::local_assets+"XMLlog.txt");
		DKLog("Saved string to XMLlog.txt \n");
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////
bool DKXml::LoadDocumentFromString(const DKString& string)
{
	DKLog("DKXml::LoadDocumentFromString("+string+")\n", DKDEBUG);
	
	DKString temp = string;
	Trim(temp);
	replace(temp, "\n", "");
	replace(temp, "\r", "");
	replace(temp, "(\"", "(");
	replace(temp, "\")", ")");

	pugi::xml_parse_result result = doc.load(temp.c_str());
	if(!result){
		std::cout << "XML parsed with errors, attr value: [" << doc.child("node").attribute("attr").value() << "]\n";
		std::cout << "Error description: " << result.description() << "\n";
		std::cout << "Error offset: " << result.offset << " (error at [..." << (temp.c_str() + result.offset) << "]\n\n";
		DKFile::StringToFile(temp, DKFile::local_assets+"XMLlog.txt");
		DKLog("Saved string to XMLlog.txt \n");
		return false;
	}
	return true;
}

////////////////////////////////////////
bool DKXml::SaveDocument(DKString& file)
{
	DKLog("DKXml::SaveDocument("+file+")\n", DKDEBUG);
	
	if(!doc.save_file(file.c_str(), "\t", pugi::format_default | pugi::format_no_declaration | pugi::format_no_escapes)){
		DKLog("Could not save xml\n", DKERROR);
		return false;
	}
	return true;
}

//////////////////////////////////////////////////
bool DKXml::SaveDocumentToString(DKString& string)
{
	DKLog("DKXml::SaveDocumentToString("+string+")\n", DKDEBUG);
	
	std::ostringstream ss; 
	doc.save(ss, "\t", pugi::format_default | pugi::format_no_declaration | pugi::format_no_escapes); 
	string = ss.str();
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKXml::SaveNodes(const DKString& xpath, const DKString& path)
{
	DKLog("DKXml::SaveNodes("+xpath+","+path+")\n", DKDEBUG);
	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;

		//TODO - removed nested .html nodes
		std::ostringstream nodess;
		node.node().print(nodess);
		DKString str = nodess.str();
		
		DKXml sub;
		sub.LoadDocumentFromString(str.c_str());
		sub.RemoveNodes("//*/*[contains(@id,'.html')]"); //remove inner nodes with id's containing ".html"
		DKString file = node.node().attribute("id").value();
		
		//FIXME - these should not be hard coded.  
		//if(same(file,"DKDev.html")){ continue; }
		//if(same(file,"DKEditor.html")){ continue; }
		//if(same(file,"DKMenuRight.html")){ continue; }
		//if(same(file,"DKMenuRightApp.html")){ continue; }
		//if(same(file,"DKMenuRightEdit.html")){ continue; }
		//if(same(file,"DKMenuRightTree.html")){ continue; }
		//if(same(file,"DKMenuRightWeb.html")){ continue; }
		//if(same(file,"DKAutomate.html")){ continue; }
		//if(same(file,"DKAutomate2.html")){ continue; }

		DKString filepath = path+"/"+file;
		sub.SaveDocument(filepath);

		DKLog("Saved "+path+"/"+file+"\n");
    }
	return true;
}


///////////////////////////////////////////
bool DKXml::FindNode(const DKString& xpath)
{
	DKLog("DKXml::FindNode("+xpath+")\n", DKDEBUG);
	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
bool DKXml::GetNode(const DKString& xpath, DKXmlNode& node)
{
	DKLog("DKXml::GetNode("+xpath+",DKXmlNode&)\n", DKDEBUG);
	
	node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////////
bool DKXml::GetNodes(const DKString& xpath, DKXmlNodes& nodes)
{
	DKLog("DKXml::GetNodes("+xpath+",DKXmlNodes&)\n", DKDEBUG);
	
	nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKXml::GetNodeNames(const DKString& xpath, DKStringArray& arry)
{
	DKLog("DKXml::GetNodeNames("+xpath+",DKStringArray&)\n", DKDEBUG);
	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		arry.push_back(node.node().name());
    }
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetAttributeValues(const DKString& xpath, const DKString& attrib, DKStringArray& arry)
{
	DKLog("DKXml::GetAttributeValues("+xpath+","+attrib+",DKStringArray&)\n", DKDEBUG);
	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		arry.push_back(node.node().attribute(attrib.c_str()).value());
    }
	return true;
}

////////////////////////////////////////////////////////////////
bool DKXml::GetFullNode(const DKString& xpath, DKString& string)
{
	DKLog("DKXml::GetFullNode("+xpath+","+string+")\n", DKDEBUG);
	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	std::ostringstream oss;
	node.print(oss);
	string = oss.str();
	//Trim(string);
	//replace(string, "\n", " ");
	//replace(string, "\r", " ");
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKXml::GetNodeValue(const DKString& xpath, DKString& string)
{
	DKLog("DKXml::GetNodeValue("+xpath+","+string+")\n", DKDEBUG);
	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	string = node.child_value();
	Trim(string);
	replace(string, "\n", " ");
	replace(string, "\r", " ");
	return true;
}

///////////////////////////////////////////////////////////////////////////////
bool DKXml::GetChildNodeValue(const DKString& xpath, int num, DKString& string)
{
	DKLog("DKXml::GetChildNodeValue("+xpath+","+toString(num)+","+string+")\n", DKDEBUG);
	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	node = node.first_child();
	int i = 0;
	while(i < num){
		node = node.next_sibling();
		++i;
	}

	string = node.child_value();
	Trim(string);
	replace(string, "\n", " ");
	replace(string, "\r", " ");
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetChildAttribute(const DKString& xpath, int num, const DKString& attrib, DKString& string)
{
	DKLog("DKXml::GetChildAttribute("+xpath+","+toString(num)+","+attrib+","+string+")\n", DKDEBUG);
	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	node = node.first_child();
	int i = 0;
	while(i < num){
		node = node.next_sibling();
		++i;
	}

	string = node.attribute(attrib.c_str()).value();
	Trim(string);
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetAttribute(const DKXmlNode& node, const DKString& attrib, DKString& string)
{
	DKLog("DKXml::GetChildAttribute(DKXmlNode&,"+attrib+","+string+")\n", DKDEBUG);
	
	string = node.attribute(attrib.c_str()).value();
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetAttribute(const DKString& xpath, const DKString& attrib, DKString& string)
{
	DKLog("DKXml::GetAttribute("+xpath+","+attrib+","+string+")\n", DKDEBUG);
	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	string = node.attribute(attrib.c_str()).value();
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::SetAttribute(DKXmlNode& node, const DKString& attrib, const DKString& value)
{
	DKLog("DKXml::SetAttribute(DKXmlNode&,"+attrib+","+value+")\n", DKDEBUG);
	
	if(!node.attribute(attrib.c_str()).as_bool()){
		node.append_attribute(attrib.c_str());
	}
	node.attribute(attrib.c_str()).set_value(value.c_str());
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::SetAttributes(const DKString& xpath, const DKString& attrib, const DKString& value)
{
	DKLog("DKXml::SetAttributes("+xpath+","+attrib+","+value+")\n", DKDEBUG);
	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		if(!node.node().attribute(attrib.c_str()).as_bool()){
			node.node().append_attribute(attrib.c_str());
		}
		node.node().attribute(attrib.c_str()).set_value(value.c_str());
    }
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKXml::AppendNode(const DKString& xpath, const DKString& type)
{
	DKLog("DKXml::AppendNode("+xpath+","+type+")\n", DKDEBUG);
	
	DKXmlNode parent = doc.select_single_node(xpath.c_str()).node();
	parent.append_child(type.c_str());
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKXml::PrependNode(const DKString& xpath, const DKString& type)
{
	DKLog("DKXml::PrependNode("+xpath+","+type+")\n", DKDEBUG);
	
	DKXmlNode parent = doc.select_single_node(xpath.c_str()).node();
	if(parent.first_child().empty()){
		parent.append_child(type.c_str());
	}
	else{
		parent.insert_child_before(type.c_str(), parent.first_child());
	}
	return true;
}

//////////////////////////////////////////////
bool DKXml::RemoveNodes(const DKString& xpath)
{
	DKLog("DKXml::RemoveNodes("+xpath+")\n", DKDEBUG);
	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	while(nodes.size()){
		DKXmlNodes::const_iterator it = nodes.begin();
		pugi::xpath_node node = *it;
		node.node().parent().remove_child(node.node());
		nodes = doc.select_nodes(xpath.c_str());
	}
	return true;
}

///////////////////////////////////////////////////////////////////////////
bool DKXml::RemoveAttributes(const DKString& xpath, const DKString& attrib)
{
	DKLog("DKXml::RemoveAttributes("+xpath+","+attrib+")\n", DKDEBUG);
	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		node.node().remove_attribute(attrib.c_str());
    }
	return true;
}

///////////////////////////////////////////////
bool DKXml::RemoveInners(const DKString& xpath)
{
	DKLog("DKXml::RemoveInners("+xpath+")\n", DKDEBUG);
	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	//TODO
	return false;

	while(nodes.size()){
		DKXmlNodes::const_iterator it = nodes.begin();
		pugi::xpath_node node = *it;
		//node.node().remove_child(???);
		nodes = doc.select_nodes(xpath.c_str());
	}
	return true;
}