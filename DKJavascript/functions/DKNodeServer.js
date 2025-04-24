var http = require('http');
var url = require('url');
var fs = require('fs');

<<<<<<< HEAD
http.createServer(function (req, res) {
  var q = url.parse(req.url, true);
  var filename = "." + q.pathname;
  fs.readFile(filename, function(err, data) {
    if (err) {
=======
http.createServer(function (req, res){
  var q = url.parse(req.url, true);
  console.log("q = "+q);
  var filename = "." + q.pathname ;
  fs.readFile(filename, function(err, data){
    if (err){
>>>>>>> Development
      res.writeHead(404, {'Content-Type': 'text/html'});
      return res.end("404 Not Found");
    } 
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write(data);
    return res.end();
  });
}).listen(8080);