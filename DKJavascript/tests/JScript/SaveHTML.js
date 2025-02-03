// Instantiate a DOM object.
var doc = new ActiveXObject("msxml2.DOMDocument.6.0");
doc.async = false;
doc.resolveExternals = false;
doc.validateOnParse = false;

// Load an XML file into the DOM instance.
doc.loadXML
  (
      "<?xml version='1.0'?>\n"
     +"<doc title='test'>\n"
     +"  <page num='1'>\n"
     +"    <para title='Saved at last'>\n"
     +"       This XML data is finally saved.\n"
     +"    </para>\n"
     +"  </page>\n"
     +"  <page num='2'>\n"
     +"    <para>\n"
     +"       This page is intentionally left blank.\n"
     +"    </para>\n"
     +"  </page>\n"
     +"</doc>\n"
  );

// Save the dom to a file.
doc.save("saved.xml");


// Helper function:
function alert(str)
{
   WScript.Echo(str);
}