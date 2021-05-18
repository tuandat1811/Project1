const express = require('express')
const app = express()
const port = process.env.PORT || '3000'

app.get('/serverConfig', (req, res) => res.send({"APP":"BKOD","IP":"http://192.168.0.101","PORT":"28146"}));
//app.get('/serverConfig', (req, res) => res.send({"APP":"BKOD","IP":"http://192.168.50.7","PORT":"28146"}));
//app.get('/serverConfig', (req, res) => res.send({"APP":"BKOD","IP":"http://system.techlinkvn.com","PORT":"28146"}));
app.get('/serverConfigNDT', (req, res) => res.send({"APP":"BKOD","IP":"http://system.techlinkvn.com","PORT":"28146"}));
 
app.listen(port, () => console.log(`Example app listening on port ${port}!`))
// Cong ty: 192.168.100.200
// Nha: 192.168.50.9
// Lab: 192.168.4.151
// Huawei: 192.168.43.126
// Asus: 192.168.43.126
// cslab-505: 192.168.15.46
// tcp/28433   webhttps
// tcp/28080   web
// tcp/28146 