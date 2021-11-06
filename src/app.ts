const express = require('express')
const app = express()
const port = 3000

var mysql = require('mysql2')

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'dorayaki_admin',
  password: 'dorayaki',
  database: 'dorayaki_factory'
})

connection.connect()

connection.query('SELECT * from recipe', function (err, rows, fields) {
  if (err) throw err

  console.log('Contoh, isi table recipe: ', rows)
})

connection.end()

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

// CREATE USER 'dorayaki_admin'@'localhost' IDENTIFIED BY 'dorayaki';
// GRANT ALL PRIVILEGES ON dorayaki_factory. * TO 'dorayaki_admin'@'localhost';