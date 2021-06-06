"use strict";
//https://www.chartjs.org/

dk.chart = new DKChart();

function DKChart() {
    return DKPlugin.call(this, arguments);
}

DKChart.prototype.init = function DKChart_init() {
    //dk.create("https://momentjs.com/downloads/moment.min.js");
    dk.create("DKTasmota/moment.min.js", function dk_create() {
        //dk.create("https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js");
        dk.create("DKChart/chart.min.js");
    });
}

DKChart.prototype.create = function DKChart_create(parent, id, top, bottom, left, right, width, height) {
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
    dk.gui.addResizeHandler(chartCanvas, function dk_gui_addResizeHandler() {//console.debug("chartCanvas resized: x:"+chartCanvas.style.width+" y:"+chartCanvas.style.height);
    //chartCanvas.width = window.innerWidth;
    //chartCanvas.height = window.innerHeight;
    //chartCanvas.style.height = "100%";
    //this.lineChart.update;
    });

    return chartCanvas;
}
