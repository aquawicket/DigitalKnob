
function DKFpsTest(){}

dk.fpstest.init function dk_fpstest_init(){
	dk.create("DKFpsTest/DKFpsTest.html", function(){});

	samplePoints = 10 //number of points to average for the red curve

	canvas = document.querySelector('canvas');
	ctx = canvas.getContext('2d');

	(onresize = function(){
	width = canvas.width = canvas.clientWidth;
	height = canvas.height = canvas.clientHeight;
	})();

	arr = [];
	arr2 = [];
	iteration=0;
	requestAnimationFrame(function(timestamp){
	var lastFrame = timestamp,
    start = timestamp,loop;
	requestAnimationFrame(loop = function(timestamp){
    ctx.fillStyle = '#111';
    ctx.fillRect(0,0,width,height);
    ctx.fillStyle = '#222';
    var scale = height/120;
    for(var x=arr.length;x>arr.length-width;x--){
      ctx.fillRect(width+x-iteration,height,1,-scale*arr[x]);
    }
    ctx.fillStyle = '#f00';
    ctx.globalAlpha = 0.2;
    ctx.beginPath();
    ctx.moveTo(width,height)
    for(var x=arr2.length;x>arr2.length-3-width/samplePoints;x--){
      ctx.lineTo(width+(x+2)*samplePoints-iteration,height-scale*arr2[x])
    }
    ctx.lineTo(width-iteration+samplePoints*2,height);
    ctx.closePath();
    ctx.fill();
    ctx.globalAlpha = 1;
    ctx.font = '70px Helvetica';
    ctx.fillStyle = '#ccc'
    ctx.textAlign = 'center';
    ctx.baseLine = 'middle';
    ctx.fillText((arr2[arr2.length-1]||0).toFixed(2),width/2,height/3);
    
    var dt = -lastFrame+(lastFrame=timestamp);
    arr.push(1000/dt);
    if(arr.length>samplePoints&&iteration%samplePoints==0){
      var a=0,
          b=0;
      for(var i=0;i<samplePoints;i++){
        a += arr[arr.length-1-i];
      }
      a /= samplePoints
      arr2.push(a)
    }
    iteration++;
    requestAnimationFrame(loop);
  });
});
}
