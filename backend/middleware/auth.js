const jwt = require("jsonwebtoken");
const connectdb = require("../connectdb.js");
const mysql = require("mysql");

module.exports = (req, res, next) => {
  try {
    // récupère le token dans le header authorization
    // split retourne un tableau avec bearer en 0 et le token en 1
    const token = req.headers.authorization.split(" ")[1];
    const decodedToken = jwt.verify(token, "BARSEILLE_TOKEN_SECRET");
    // récupère le userId du token
    const userId = decodedToken.userId;
    let sqlInserts = [userId];
    let sql = "SELECT COUNT(id) FROM users WHERE id=?";
    sql = mysql.format(sql, sqlInserts);

     // vérifier que le userId de la requête correspond à celui du token
    connectdb.query(sql, function (err, result) {
      if (err) reject({ error: "Erreur dans l'inscription" });
      if (result[0]["COUNT(id)"] !== 1) {
        throw "Token invalide";
      } else {
        next();
      }
    });
  } catch (error) {
    res.status(401).json({ error: error | "Requête non authentifiée!" });
  }
};
