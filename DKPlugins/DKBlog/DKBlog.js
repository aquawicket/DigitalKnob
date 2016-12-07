
///////////////////////
function DKBlog_Init()
{
	//DKLog("DKBlog_Init() \n");
	DKCreate("DKBlog/DKBlog.html");
}

/////////////////////
function DKBlog_End()
{
	DKClose("DKBlog/DKBlog.html");
}

//////////////////////////////
function DKBlog_OnEvent(event)
{
	DKLog("DKBlog_OnEvent("+event+")\n", DKINFO);
}