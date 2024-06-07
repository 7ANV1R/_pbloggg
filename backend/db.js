const mongoose = require("mongoose");
require("dotenv").config();

// db url from .env file
const dbUrl = process.env.DB_URL;
// connecting to db
mongoose.connect(dbUrl);

// db instance
const db = mongoose.connection;

// listener for db events
db.on("connected", () => console.log("Connected to the database"));
db.on("disconnected", () => console.log("Disconnected from the database"));
db.on("error", (error) =>
  console.log("error connecting to the database. Err:", error)
);

module.exports = db;
