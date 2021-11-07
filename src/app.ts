const express = require('express')
const cors = require('cors')
const app = express()
const bcrypt = require('bcrypt');
const saltRounds = 10;

app.use(cors())
app.use(express.json());

const port = 4000

var mysql = require('mysql2')

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'dorayaki_admin',
  password: 'dorayaki',
  database: 'dorayaki_factory'
})

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.post('/login', (req, res) => {
  console.log(req.body)
  var uname = req.body.uname
  var pass = req.body.password
  connection.connect()
  connection.query('SELECT * from user where username=?', [ uname ], 
  function (err, rows) {
    if (err) res.send({err: err})
    console.log('User: ', rows)
    if (rows.length > 0){
      bcrypt.compare(pass, rows[0].password, function(err, result) {
        console.log(result)
        if (result){
          res.send(result)
        } else{
          res.send({err: "password doesn't match"})
        }
      });
    } else{
      res.send({err: "user doesn't exist"})
    }
  })
  // connection.end()
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})