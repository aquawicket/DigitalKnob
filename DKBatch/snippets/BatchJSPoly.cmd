0</* :
::########################## BATCH ############################

@echo off
echo ---------- Begin Batch ----------
echo:
echo:

echo 0 = %~0
echo * = %*

echo:
echo:
echo ----------- End Batch ----------

::########################## BATCH ############################
@cscript /nologo /E:jscript "%~f0" "%~nx0" %* & goto :EOF & */0;
//######################### Jscript ###########################

WScript.Echo('--------- Begin jscript---------');
WScript.Echo('');
WScript.Echo('');

//var name = 'ARGV';
//var num = 0;
//var value = 'value';
//eval('var '+name+num+' = '+value+';');
//WScript.Echo('ARGV0 = '+ARGV0);

var ARGC = WScript.Arguments.length;
var ARGV = [];
for (var i = 0; i < ARGC; i++){
	ARGV.push(WScript.Arguments.Item(i));
}
WScript.Echo("ARGV = "+ARGV);
WScript.Echo("ARGC = "+ARGC);



//WScript.Echo("ARGVC = "+WScript.Arguments.Named.length);
//WScript.Echo("ARGNC = "+WScript.Arguments.Unnamed.length);


WScript.Echo('');
WScript.Echo('');
WScript.Echo('---------- End jscript!--------- ');

//######################### Jscript ###########################