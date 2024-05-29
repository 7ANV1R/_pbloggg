const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const logger = require("./middleware/logger");
require("./db");

// express instance
const app = express();

// Middlewares
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(logger());

// Routes
const Route = require("./routes/index");

// API URL's
app.use("/api", Route);

// App Port
const port = process.env.PORT || 4000;
app.listen(port, () => {
  console.log(`App running on ${port} port`);
});
