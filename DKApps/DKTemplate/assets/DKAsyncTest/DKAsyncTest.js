/////////////////////////////////
async function DKAsyncTest_Init()
{
	DKLog("DKAsyncTest_Init()\n", DKINFO);
	DKLog("first\n");
	await DKAsyncTest_test();
	DKLog("fourth\n");
}

////////////////////////
async function sleep(ms)
{
	return new Promise(resolve => setTimeout(resolve, ms));
}

/////////////////////////////////
async function DKAsyncTest_test()
{
	DKLog("second\n");
	DKLog("waiting 2 seconds\n");
	await sleep(2000);
	DKLog("third\n");
}