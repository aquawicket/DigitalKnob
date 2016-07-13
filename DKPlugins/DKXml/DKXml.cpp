#include "stdafx.h"
#include "DKXml.h"
#include "DKFile.h"

//////////////////
void DKXml::Init()
{

}

/////////////////
void DKXml::End()
{

}

//////////////////////////////////////////////
bool DKXml::LoadDocument(const DKString& file)
{
	DKString path = file;
	if(!DKFile::VerifyPath(path)){ return false; } 

	DKString filedata;
	DKFile::FileToString(path,filedata);

	pugi::xml_parse_result result = doc.load(filedata.c_str(), pugi::parse_cdata | pugi::parse_wconv_attribute | pugi::parse_eol);
	if(!result){
		DKString description = result.description();
		DKString offset = toString((int)result.offset);
		DKLog("DKXml::LoadDocument("+file+"): "+description+" @ character: "+offset+" \n", DKERROR);
		DKFile::StringToFile(filedata, DKFile::local_assets+"USER/XMLlog.txt");
		DKLog("Saved string to XMLlog.txt \n", DKINFO);
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////
bool DKXml::LoadDocumentFromString(const DKString& string)
{
	DKString temp = string;
	Trim(temp);
	replace(temp, "\n", "");
	replace(temp, "\r", "");
	replace(temp, "(\"", "(");
	replace(temp, "\")", ")");

	pugi::xml_parse_result result = doc.load(temp.c_str());
	if(!result){
		/*
		DKString description = result.description();
		DKString offset = toString((int)result.offset);
		DKLog("DKXml::LoadDocumentFromString(): "+description+" @ character: "+offset+" \n", DKERROR);
		DKFile::StringToFile(temp, DKFile::local_assets+"USER/XMLlog.txt");
		DKLog("Saved string to XMLlog.txt \n", DKINFO);
		*/
		std::cout << "XML parsed with errors, attr value: [" << doc.child("node").attribute("attr").value() << "]\n";
		std::cout << "Error description: " << result.description() << "\n";
		std::cout << "Error offset: " << result.offset << " (error at [..." << (temp.c_str() + result.offset) << "]\n\n";
		DKFile::StringToFile(temp, DKFile::local_assets+"USER/XMLlog.txt");
		DKLog("Saved string to XMLlog.txt \n", DKINFO);
		return false;
	}
	return true;
}

////////////////////////////////////////
bool DKXml::SaveDocument(DKString& file)
{
	if(!doc.save_file(file.c_str(), "\t", pugi::format_default | pugi::format_no_declaration | pugi::format_no_escapes)){
		DKLog("Could not save xml\n", DKERROR);
		return false;
	}
	return true;
}

//////////////////////////////////////////////////
bool DKXml::SaveDocumentToString(DKString& string)
{
	std::ostringstream ss; 
	doc.save(ss); 
	string = ss.str();
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKXml::SaveNodes(const DKString& xpath, const DKString& path)
{
	pugi::xpath_node_set nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(pugi::xpath_node_set::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
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
		if(same(file,"DKDev.html")){ continue; }
		if(same(file,"DKEditor.html")){ continue; }
		if(same(file,"DKMenuRight.html")){ continue; }
		if(same(file,"DKMenuRightApp.html")){ continue; }
		if(same(file,"DKMenuRightEdit.html")){ continue; }
		if(same(file,"DKMenuRightTree.html")){ continue; }
		if(same(file,"DKMenuRightWeb.html")){ continue; }
		if(same(file,"DKAutomate.html")){ continue; }
		if(same(file,"DKAutomate2.html")){ continue; }

		DKString filepath = path+"/"+file;
		sub.SaveDocument(filepath);

		DKLog("Saved "+path+"/"+file+"\n", DKINFO);
    }
	return true;
}


////////////////////////////////////////////////////////
DKStringArray DKXml::GetNodeNames(const DKString& xpath)
{
	pugi::xpath_node_set nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return DKStringArray(0);
	}

	DKStringArray arry;
	for(pugi::xpath_node_set::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		arry.push_back(node.node().name());
    }
	return arry;
}

//////////////////////////////////////////////////////////////////////////////////////
DKStringArray DKXml::GetAttributeValues(const DKString& xpath, const DKString& attrib)
{
	pugi::xpath_node_set nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return DKStringArray(0);
	}

	DKStringArray arry;
	for(pugi::xpath_node_set::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		arry.push_back(node.node().attribute(attrib.c_str()).value());
    }
	return arry;
}

//////////////////////////////////////////////////
DKString DKXml::GetFullNode(const DKString& xpath)
{
	pugi::xml_node node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return "";
	}

	std::ostringstream oss;
	node.print(oss);
	DKString xml = oss.str();
	//Trim(string);
	//replace(string, "\n", " ");
	//replace(string, "\r", " ");
	return xml;
}

///////////////////////////////////////////////////
DKString DKXml::GetNodeValue(const DKString& xpath)
{
	pugi::xml_node node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return "";
	}

	DKString string;
	string = node.child_value();
	Trim(string);
	replace(string, "\n", " ");
	replace(string, "\r", " ");
	return string;
}

/////////////////////////////////////////////////////////////////
DKString DKXml::GetChildNodeValue(const DKString& xpath, int num)
{
	pugi::xml_node node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return "";
	}

	DKString string;
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
	return string;
}

/////////////////////////////////////////////////////////////////////////////////////////
DKString DKXml::GetChildAttribute(const DKString& xpath, int num, const DKString& attrib)
{
	pugi::xml_node node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return "";
	}

	DKString string;
	node = node.first_child();
	int i = 0;
	while(i < num){
		node = node.next_sibling();
		++i;
	}

	string = node.attribute(attrib.c_str()).value();
	Trim(string);
	return string;
}

///////////////////////////////////////////////////////////////////////////
DKString DKXml::GetAttribute(const DKString& xpath, const DKString& attrib)
{
	pugi::xml_node node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return "";
	}

	DKString value;
	value = node.attribute(attrib.c_str()).value();
	return value;
}

///////////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::SetAttributes(const DKString& xpath, const DKString& attrib, const DKString& value)
{
	pugi::xpath_node_set nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(pugi::xpath_node_set::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		node.node().attribute(attrib.c_str()).set_value(value.c_str());
    }
	return true;
}

//////////////////////////////////////////////
bool DKXml::RemoveNodes(const DKString& xpath)
{
	pugi::xpath_node_set nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	while(nodes.size()){
		pugi::xpath_node_set::const_iterator it = nodes.begin();
		pugi::xpath_node node = *it;
		node.node().parent().remove_child(node.node());
		nodes = doc.select_nodes(xpath.c_str());
	}
	return true;
}

///////////////////////////////////////////////////////////////////////////
bool DKXml::RemoveAttributes(const DKString& xpath, const DKString& attrib)
{
	pugi::xpath_node_set nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	for(pugi::xpath_node_set::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		node.node().remove_attribute(attrib.c_str());
    }
	return true;
}

///////////////////////////////////////////////
bool DKXml::RemoveInners(const DKString& xpath)
{
	pugi::xpath_node_set nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKLog("Could not find xpath: "+xpath+"\n", DKWARN);
		return false;
	}

	//TODO
	return false;

	while(nodes.size()){
		pugi::xpath_node_set::const_iterator it = nodes.begin();
		pugi::xpath_node node = *it;
		//node.node().remove_child(???);
		nodes = doc.select_nodes(xpath.c_str());
	}
	return true;
}

