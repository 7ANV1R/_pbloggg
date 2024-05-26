const express = require("express");
const router = express.Router();

// v1
const v1Route = require("./v1/v1.index");
router.use("/v1", v1Route);

module.exports = router;
