var pos1;
var animation1 = 1;
var pos2;
var animation2 = 1;

///////////////////////
function Animation_Init()
{
	DKCreate("Animation.html");
	DKAddEvent("box1", "click", Animation_OnEvent);
	DKAddEvent("box2", "click", Animation_OnEvent);
}

////////////////////////
function Animation_End()
{
	DKClose("Animation.html");
}

///////////////////////////////
function Animation_OnEvent(event)
{
	DKLog("Animation_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "box1")){
		pos1 = -100;
		animation1 = setInterval(Animation_Box1, 100);
	}
	if(DK_Id(event, "box2")){
		pos2 = -100;
		animation2 = setInterval(Animation_Box2, 1);
	}
}

/////////////////////////
function Animation_Box1()
{
    if(pos1 == 0){
        clearInterval(animation1);
    } 
	else{
        pos1++; 
		pos1++; 
		DKWidget_SetProperty("box1","left",pos1+"rem");
		DK_DoFrame();
    }
}

/////////////////////////
function Animation_Box2()
{
    if(pos2 == 0){
        clearInterval(animation2);
    } 
	else{
        pos2++; 
		DKWidget_SetProperty("box2","right",pos2+"rem");
		DK_DoFrame();
    }
}