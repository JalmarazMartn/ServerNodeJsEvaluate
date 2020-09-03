// Install request by running "npm install --save request"
var request = require("request");
auth = require('./ApiKey.json');
var options = { method: 'POST',
  url: 'https://3e71fc70.eu-gb.apigw.appdomain.cloud/evaluate-bool-expression/Evaluate',
  headers: 
   { accept: 'application/json',
     'content-type': 'application/json',
    'x-ibm-client-id': auth.apikey },
  body: { Formula: "(1+1=3) or (1+1 = 2)" },
  json: true };

request(options, function (error, response, body) {
  if (error) return console.error('Failed: %s', error.message);

  console.log('Success: ', body);
});