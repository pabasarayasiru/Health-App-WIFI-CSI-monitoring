const admin = require("firebase-admin");
require("dotenv").config();

var serviceAccount = require("../../serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

console.log("Firebase connected");

module.exports = db;
