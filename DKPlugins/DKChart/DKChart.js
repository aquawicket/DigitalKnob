"use strict";
//https://www.chartjs.org/

dk.chart = new Object;

dk.chart.init = function dk_chart_init() {
    //dk.create("https://momentjs.com/downloads/moment.min.js");
    dk.create("DKTasmota/moment.min.js");
    //dk.create("https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js");
    dk.create("DKChart/chart.min.js");
}

dk.chart.create = function dk_chart_create(parent, id, top, bottom, left, right, width, height) {
    const chartDiv = document.createElement("div");
    chartDiv.id = id;
    chartDiv.style.position = "absolute";
    chartDiv.style.backgroundColor = "rgb(70,70,70)";
    chartDiv.style.top = top;
    chartDiv.style.bottom = bottom;
    chartDiv.style.left = left;
    chartDiv.style.right = right;
    chartDiv.style.width = width;
    chartDiv.style.height = height;
    parent.appendChild(chartDiv);

    const chartCanvas = document.createElement("canvas");
    chartCanvas.id = "chartCanvas";
    chartCanvas.style.position = "absolute";
    chartCanvas.style.top = "0rem";
    chartCanvas.style.left = "0rem";
    //chartCanvas.style.bottom = "0rem";
    //chartCanvas.style.right = "0rem";
    chartCanvas.style.width = "100%";
    chartCanvas.style.height = "100%";
    
    const ctx = chartCanvas.getContext('2d');
    chartDiv.appendChild(chartCanvas);

    //FIXME - do proper refreshing on resize    
    dk.gui.addResizeHandler(chartCanvas, function() {//console.debug("chartCanvas resized: x:"+chartCanvas.style.width+" y:"+chartCanvas.style.height);
    //chartCanvas.style.height = "100%";
    //this.lineChart.resize("100%","100%");
    });
	
	return ctx;
}

