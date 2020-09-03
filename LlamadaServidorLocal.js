var request = require('request');
//CallingRepl();
Calllocal();
function Calllocal(){
const UrlDestino = "http://192.168.1.7:8080";
//const UrlDestino = "http://localhost:8080";
request.post({
        url:     UrlDestino,
        body:    '(1+1=2) AND (1=2)'
      }, function(error, response, body){
        console.log(body);        
      });
    }
function CallingRepl(){

            const UrlDestino = "https://istrueevaluator.jalmarazmartn.repl.co/Evaluate";
            request.post({
                    url:     UrlDestino,
                    headers: {
                      "Content-Type": "application/json"
                    },            
                    body:    '{"Formula":"(1+1a==2)"}'
                  }, function(error, response, body){
                    console.log(response.body);
                  });
                }      
function CallingReplWithGet(){
  const UrlDestino = 'https://istrueevaluator.jalmarazmartn.repl.co/';
  request.get(UrlDestino, function(err, res, body) {  
    console.log(body);});
      }          
        