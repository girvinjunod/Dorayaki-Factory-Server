const express = require('express')
const cors = require('cors')
const app = express()
const bcrypt = require('bcrypt')
const saltRounds = 10;
const jwt = require('jsonwebtoken')
const cookieParser = require('cookie-parser')
const redis = require('redis');

app.use(cors({ origin: 'http://localhost:3000', credentials: true }));
app.use(express.json())
app.use(cookieParser())
require("dotenv").config();

const redisPort = 6379
const client = redis.createClient({
  host: process.env.REDIS_HOST,
  post: redisPort
})

const port = 4000

var mysql = require('mysql2')

var connection = mysql.createPool({
  connectionLimit: 10,
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DB,
})

client.on("error", (err) => {
  console.log("Redis")
  console.log(err)
})


app.get('/', (req, res) => {
  res.send('Hello World! pisang')
})

app.get('/test/1', (req, res) => {
  // console.log("host", process.env.MYSQL_HOST)
  // console.log("user", process.env.MYSQL_USER)
  // console.log("password", process.env.MYSQL_PASSWORD)
  // console.log("database", process.env.MYSQL_DB)
  // console.log("pisang")
  // console.log(process.env.REDIS_HOST)
  // client.get('apel', function(err, reply) {
  //   console.log("get")
  //   console.log(reply)
  // })

  // client.set('apel', 'jeruk', function(err, reply) {
  //   console.log("set")
  //   console.log(reply) // OK
  // })


  res.send('Pisang')
})




//auth token pengguna
app.get('/auth', (req, res) => {
  let token = req.cookies.token
  if (!token){
    res.send({auth: false, err: "no token"})
  } else{
    jwt.verify(token, process.env.SECRET, (err, decode) => {
      if (err){
        res.send({auth: false, err: "Failed to verify token"})
      } else{
        // console.log("verified")
        // console.log(decode)
        res.send({auth: true, username:decode.username})
      }

    })
  }
})

//logout
app.get('/logout', (req, res) => {
  let cookie = req.cookies
  res.cookie('token', cookie.token, {expires: new Date(0)})
  res.end()
})



//validasi keunikan input username di register
app.get('/valuname', (req, res) => {
  let uname = req.query.username
  // console.log("username", uname)
  if (uname == ""){
    res.send({auth: false, err:"empty username"})
    
  } else {
    connection.query('SELECT * from user where username=?', [ uname ], 
    function (err, rows) {
      // console.log(rows)
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


//register
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
      // console.log("username unik")
      unik = true
    }
  console.log(unik)
  if (unik){
    bcrypt.hash(password, saltRounds, function(err, hash) {
      // console.log(hash)
      connection.query('INSERT INTO user(email,username,password) VALUES (?,?,?)', [ email,uname,hash ], 
      function (err, rows) { 
      if (err) {
        res.send({auth: false, err: err})
        // console.log(err)
      }
      else{
        // console.log(rows)
        let id = rows.insertID
        const token = jwt.sign({id}, process.env.SECRET, {
          expiresIn: 600
        })
        let options = {
          maxAge: 1000 * 60 * 10,
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



//login
app.post('/login', (req, res) => {
  // console.log(req.body)
  var uname = req.body.uname
  var pass = req.body.password
  // connection.connect()
  connection.query('SELECT * from user where username=?', [ uname ], 
  function (err, rows) {
    if (err){
      res.send({auth: false, err: err})
      return 
    } 
    // console.log('User: ', rows)
    if (rows.length > 0){
      bcrypt.compare(pass, rows[0].password, function(err, result) {
        // console.log(result)
        if (result){
          const id = rows[0].id_user
          const uname = rows[0].username
          const token = jwt.sign({id:id, username: uname}, process.env.SECRET, {
            expiresIn: 600
          })
          // console.log(id)

          // console.log(req.cookies) 

          let options = {
              maxAge: 1000 * 60 * 10,
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

//getDetails
app.get('/getDetails/:id', (req, res) => {
  let id = req.params.id
  // console.log("id=", id)
  let key = 'details:'+id
  client.get(key, function(err, reply) {
    // console.log("get")
    // console.log(reply)
    if (err){
      console.log(err)
      res.send({auth: false, err: err})
      return
    }
    else if (reply){
      console.log("response dari cache")
      let cachedata = JSON.parse(reply)
      // console.log("cache data", cachedata)
      res.send(cachedata)
      return
    } else{
      connection.query('select id_material, recipe_name, recipe_desc, amount, material_name from recipe natural join recipe_material natural join material where id_recipe=?', [ id ] , 
      function (err, rows) {
        if (err){
          res.send({auth: false, err: err})
          return 
        }
        else{
          if (rows.length > 0){
            // console.log(rows)
            let name = rows[0].recipe_name
            let desc = rows[0].recipe_desc
            let material = rows.map( (row) => {
              return {
                id: row.id_material,
                mat: row.amount + " " + row.material_name
              }
            })
            let response = {auth:true, name: name, desc:desc, material:material }
            client.set(key, JSON.stringify(response), function(err, reply) {
              console.log("set cache")
              if (err){
                console.log(err)
              }else{
                console.log(reply)
              }
            })
            res.send(response)
            return
          } else{
            let response = {auth: false, err:"No recipe found"}
            client.set(key, JSON.stringify(response), function(err, reply) {
              console.log("set cache")
              if (err){
                console.log(err)
              }else{
                console.log(reply)
              }
            })
            res.send(response)
            return
          }
        }
      })
    }
  })
})

app.get('/getAllRecipe', (req,res) => {
    client.get('getallrecipe', function(err, reply) {
      console.log("get")
      console.log(reply)
      if (err){
        console.log(err)
        res.send({auth: false, err: err})
        return
      } else if (reply){
        console.log("response dari cache")
        let cachedata = JSON.parse(reply)
        console.log("cache data", cachedata)
        res.send(cachedata)
        return
      } else{
        connection.query('select * from recipe', 
        function (err, rows) {
          if (err){
            res.send({auth: false, err: err})
            return 
          } else{
            if (rows.length > 0){
              console.log(rows)
              let response = {auth: true, part: rows}
              client.set("getallrecipe", JSON.stringify(response), function(err, reply) {
                console.log("set cache")
                if (err){
                  console.log(err)
                }else{
                  console.log(reply)
                }
              })
              res.send(response)
            }else {
              let response = {auth: false, part: 'gada resep'}
              client.set("getallrecipe", JSON.stringify(response), function(err, reply) {
                console.log("set cache")
                if (err){
                  console.log(err)
                }else{
                  console.log(reply)
                }
              })
              res.send(response)
            }
            return
          }
        })
      }
  
  })

})

app.get('/getAllMaterial', (req,res) => {
  connection.query('select * from material', 
  function (err, rows) {
    if (err){
      res.send({auth: false, err: err})
      return 
    } else{
      if (rows.length > 0){
        console.log(rows)
        res.send({auth: true, part: rows})
      }else {
        res.send({auth: false, part: 'gada resep'})
      }
      return
    }
  })
})

app.post('/addMaterial', (req,res) => {
  if (req.body.stokMaterial < 0 || req.body.namaMaterial == ''){
    res.send({err:true})
    return
  }
  else{
    connection.query('insert into material(material_name,material_stock) VALUES (?,?)', [req.body.namaMaterial,req.body.stokMaterial],
    function(err,rows){
      if (err){
        res.send({err:true})      
      } else{
        res.send({err:false})
      }
      return
    })
  }
})

app.post('/addRecipe', (req,res) => {
  if (req.body.namaRecipe == '' || req.body.deskripsiRecipe == ''){
    res.send({err:true}) 
    return    
  }
  for (let i=0; i<req.body.dataRecipe; i++){
    if (req.body.dataRecipe[i].countMaterial < 0 || req.body.dataRecipe[i].materialName == ''){
      res.send({err:true}) 
      return
    }
  }
  let insertId = 0;
  connection.query('insert into recipe(recipe_name,recipe_desc) VALUES (?,?)', [req.body.namaRecipe,req.body.deskripsiRecipe],
  function(err,rows){
    if (err){
      res.send({err:true})
    }else{
      console.log('mangga benar')
      insertId = rows.insertId;
      console.log(req.body.dataRecipe)
      console.log(req.body.dataRecipe.map(item => [insertId, item.materialName, item.countMaterial]))
      connection.query('insert into recipe_material VALUES ?', [req.body.dataRecipe.map(item => [insertId, item.materialName, item.countMaterial])],
      function(error,rows2){
        if (error){
          connection.query('delete from recipe where id_recipe = ?',[insertId])
          res.send({err:true})
        }else{
          console.log(rows2)
          connection.query('select * from recipe', 
          function (err, rows) {
            if (err){
              console.log("failed to set cache")
            } else{
                console.log(rows)
                let response = {auth: true, part: rows}
                client.set("getallrecipe", JSON.stringify(response), function(err, reply) {
                  console.log("set cache")
                  if (err){
                    console.log(err)
                  }else{
                    console.log(reply)
                  }
                })
            }
          })
          res.send({err:false})
        }
        return
      })        
    }
  })
})

app.get('/editMaterial/:id', (req,res) => {
  let id = req.params.id
  connection.query('select id_material, material_name, material_stock from material where id_material=?', [ id ] ,  
  function (err, rows) {
    if (err){
      res.send({auth: false, err: err})
      return 
    } else{
      if (rows.length > 0){
        console.log(rows)
        let name = rows[0].material_name
        let stock = rows[0].material_stock
        let response = {auth:true, name: name, stock:stock }
        console.log(response)
        
        res.send(response)
      } else {
        res.send({auth: false, err: 'Material not found'})
      }
      return
    }
  })
})

app.post('/editMaterial/', (req,res) => {
  if (req.body.stokMaterial < 0 || req.body.namaMaterial == ''){
    res.send({err:true})
    return
  }
  else{
    connection.query('UPDATE material SET material_stock = ? WHERE material_name = ?', [req.body.stokMaterial,req.body.namaMaterial],
    // connection.query('insert into material(material_name,material_stock) VALUES (?,?)', [req.body.namaMaterial,req.body.stokMaterial],
    function(err,rows){
      if (err){
        res.send({err:true})      
      } else{
        res.send({err:false})
      }
      return
    })
  }
})


app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})