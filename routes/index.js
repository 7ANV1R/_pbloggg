const express = require("express");
const router = express.Router();

// Routes
const blogRouter = require("./blog");
router.use("/blog", blogRouter);

const storageRouter = require("./storage");
router.use("/storage", storageRouter);

module.exports = router;
