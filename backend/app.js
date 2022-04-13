const express = require("express");
const app = express();
const dotenv = require("dotenv").config();
const xss = require("xss-clean"); // pour nettoyer les entrées utilisateur provenant du corps POST, des requêtes GET et des paramètres d'URL
const helmet = require("helmet");
const cors = require("cors");
const routesPosts = require("./routes/routesPosts");
const routesUsers = require("./routes/routesUsers");
const routesMod = require("./routes/routesMod");
const path = require("path");
const mysql = require("mysql");
const bodyparser = require("body-parser");
app.use(bodyparser.json());
app.use(xss());
app.use(helmet());

//(CORS) ajout des headers pour que tous les origines puissent communiquer entre eux
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content, Accept, Content-Type, Authorization"
  );
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, POST, PUT, DELETE, PATCH, OPTIONS"
  );
  next();
});

app.use("/api/posts", routesPosts);
app.use("/api/auth", routesUsers);
app.use("/api/moderation", routesMod);
app.use("../images", express.static(path.join(__dirname, "images"))); // gestion des fichiers avec multer

module.exports = app;
