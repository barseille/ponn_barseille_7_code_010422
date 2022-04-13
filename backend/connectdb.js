const mysql = require("mysql");
const app = require("./app");
const dotenv = require("dotenv").config();
console.log( "Connexion à la base de données...");

let connectdb = mysql.createConnection({
  host: "localhost",
  user:process.env.DB_USERNAME,
  password:process.env.DB_PASSWORD,
  // database: process.env.DB_DATABASE,


});
// connectdb.connect(function (err) {
//   if (err) throw err;
//   console.log("Connecté sur MySQL");
// });

connectdb.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }

  console.log('connected as id ' + connection.threadId);
});














module.exports = connectdb;
