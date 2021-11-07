const express = require('express')
const cors = require('cors')
const app = express()
const bcrypt = require('bcrypt');
const saltRounds = 10;
const jwt = require('jsonwebtoken')

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


const verifyJWT = (req, res, next) => {
  const token = req.headers["x-access-token"]

  if (!token){
    res.send("no token")
  } else{
    jwt.verify(token, "pisangjerukanjing", (err, decode) => {
      if (err){
        res.send({auth: false, err: "Failed to verify token"})
      } else{
        console.log("verified")
        next()
      }

    })
  }
}

app.post('/login', (req, res) => {
  console.log(req.body)
  var uname = req.body.uname
  var pass = req.body.password
  // connection.connect()
  connection.query('SELECT * from user where username=?', [ uname ], 
  function (err, rows) {
    if (err) res.send({err: err})
    console.log('User: ', rows)
    if (rows.length > 0){
      bcrypt.compare(pass, rows[0].password, function(err, result) {
        console.log(result)
        if (result){
          const id = rows[0].id
          const token = jwt.sign({id}, "pisangjerukanjing", {
            expiresIn: 300
          })
          console.log(id)

          res.send({auth: true, token:token, result: result})
        } else{
          res.send({auth: false, err: "password doesn't match"})
        }
      });
    } else{
      res.send({auth: false, err: "user doesn't exist"})
    }
  })
  // connection.end()
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})