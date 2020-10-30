"use strict";
const http = require('http');
const { strict } = require('assert');
const { on } = require('process');
//const url = require('url');
const server = http.createServer((request, response) => {
  let boolexpr = '';
  request.on('data', function (data) {
    for (var i = 0; i < data.length; i++) {
      boolexpr += String.fromCharCode(data[i]);
    }
    response.writeHead(200, { 'Content-Type': 'text/plain' });
    //console.log(AlmostSafe(SQLToJSBooleanNotation(boolexpr)));
    //console.log(IsTrue(boolexpr));              
    console.log('Input ' + boolexpr + '=' + IsTrue(boolexpr));
    response.end(boolexpr + ' ' + AlmostSafe(boolexpr) + '==>' + IsTrue(boolexpr))
  });
})
server.listen(8080);
console.log('Service up');
function IsTrue(inputexpr = 'textdef') {
  try {
    var inputexprModified = SQLToJSBooleanNotation(inputexpr);
    inputexprModified = AlmostSafe(inputexprModified);
    if (eval(AlmostSafe(inputexprModified))) {
      return ('true')
    } else {
      return ('false')
    }
  }
  catch (error) { return (error) };
}
function AlmostSafe(original) {
  return (original.replace(/[A-Za-z]/g, ''));
}
function SQLToJSBooleanNotation(original) {
  var JSNotation = original;
  JSNotation = JSNotation.replace(/and/gi, '&&');
  JSNotation = JSNotation.replace(/or/gi, '||');
  JSNotation = JSNotation.replace(/not/gi, '!');
  JSNotation = JSNotation.replace(/([^=&^>&^<])(=)([^=])/g, "$1 == $3");
  return (JSNotation);
}        
