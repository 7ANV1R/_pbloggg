const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
require("./db");

// express instance
const app = express();

// Middlewares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cors());

// Routes
const Route = require("./routes/index");

// API URL's
app.use("/api", Route);

// App Port
const port = process.env.PORT || 4000;
app.listen(port, () => {
  console.log(`App running on ${port} port`);
});
