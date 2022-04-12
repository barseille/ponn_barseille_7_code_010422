/*
* multer est un package de gestion de fichiers.
* méthode diskStorage() configure le chemin et le nom du fichier pour les fichiers entrants.
* méthode single() crée un middleware qui capture les fichiers d'un certain type (passé en argument) 
* et les enregistre au système de fichiers du serveur à l'aide du storage configuré
*/
const multer = require('multer');


const MIME_TYPES = {
  'image/jpg': 'jpg',
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/gif' : 'gif',
  'image/webp' : 'webp'
};

const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    callback(null, 'images');
  },
  filename: (req, file, callback) => {
    const extPath = path.extname(`/images/${file.originalname}`);
    const name = file.originalname.split(' ').join('_').split(extPath).join('');
    const extension = MIME_TYPES[file.mimetype];
    callback(null, name + '_' + Date.now() + '.' + extension);
  }
});

module.exports = multer({storage: storage}).single('image');