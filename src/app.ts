const express = require('express')
const cors = require('cors')
const app = express()
const bcrypt = require('bcrypt');
const saltRounds = 10;
const jwt = require('jsonwebtoken')
const cookieParser = require('cookie-parser')

app.use(cors({ origin: 'http://localhost:3000', credentials: true }));
app.use(express.json())
app.use(cookieParser())

const port = 4000

var mysql = require('mysql2')

// var connection = mysql.createConnection({
//   host: 'localhost',
//   user: 'dorayaki_admin',
//   password: 'dorayaki',
//   database: 'dorayaki_factory'
// })

var connection = mysql.createConnection({
  host: 'mysql',
  user: 'root',
  password: 'password',
  database: 'dorayaki_factory'
})

app.get('/', (req, res) => {
  res.send('Hello World!')
})


app.get('/auth', (req, res) => {
  let token = req.cookies.token
  if (!token){
    res.send({auth: false, err: "no token"})
  } else{
    jwt.verify(token, "pisangjerukanjing", (err, decode) => {
      if (err){
        res.send({auth: false, err: "Failed to verify token"})
      } else{
        console.log("verified")
        res.send({auth: true})
      }

    })
  }
})

app.get('/valuname', (req, res) => {
  let uname = req.query.username
  console.log(uname)
  if (uname == ""){
    res.send({auth: false, err:"empty username"})
    
  } else {
    connection.query('SELECT * from user where username=?', [ uname ], 
    function (err, rows) {
      if (err){
        res.send({auth:false, err: err})
        return
      } 
      if (rows.length > 0){
        res.send({auth: false, err: "User already exist"})
        return
      } else{
        res.send({auth: true})
      }
   })
  }

})

app.post('/register', (req, res) => {
  var uname = req.body.uname
  var email = req.body.email
  var password = req.body.password
  var conf = req.body.conf
  var unik = false

  if (!email.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/i)){
    res.send({auth: false, err: "email invalid"})
    return
  }

  if (password < 6){
    res.send({auth:false, err: "password invalid"})
    return 
  }

  if (conf != password){
    res.send({auth:false, err: "password invalid"})
    return 
  }

  connection.query('SELECT * from user where username=?', [ uname ], 
  function (err, rows) {
    if (err){
      res.send({auth:false, err: err})
      return
    } 
    if (rows.length > 0){
      res.send({auth: false, err: "User already exist"})
      return
    } else{
      console.log("username unik")
      unik = true
    }
  console.log(unik)
  if (unik){
    bcrypt.hash(password, saltRounds, function(err, hash) {
      console.log(hash)
      connection.query('INSERT INTO user(email,username,password) VALUES (?,?,?)', [ email,uname,hash ], 
      function (err, rows) { 
      if (err) {
        res.send({auth: false, err: err})
        console.log(err)
      }
      else{
        console.log(rows)
        let id = rows.insertID
        const token = jwt.sign({id}, "pisangjerukanjing", {
          expiresIn: 300
        })
        let options = {
          maxAge: 1000 * 60 * 5,
          httpOnly: true,
          sameSite: true
       }
  
        // Set cookie
        res.cookie('token', token, options)
        res.send({auth: true})
  
      }
      })
     
    })
  } else{
    res.send({auth: false, err:"username not unique"})
  }
})
})


app.post('/login', (req, res) => {
  console.log(req.body)
  var uname = req.body.uname
  var pass = req.body.password
  // connection.connect()
  connection.query('SELECT * from user where username=?', [ uname ], 
  function (err, rows) {
    if (err){
      res.send({auth: false, err: err})
      return 
    } 
    console.log('User: ', rows)
    if (rows.length > 0){
      bcrypt.compare(pass, rows[0].password, function(err, result) {
        console.log(result)
        if (result){
          const id = rows[0].id_user
          const token = jwt.sign({id}, "pisangjerukanjing", {
            expiresIn: 300
          })
          console.log(id)

          // console.log(req.cookies) 

          let options = {
              maxAge: 1000 * 60 * 5,
              httpOnly: true,
              sameSite: true
          }

          // Set cookie
          res.cookie('token', token, options)
          // console.log(res)
          res.send({auth: true, result: result})
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